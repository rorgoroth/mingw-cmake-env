#!/bin/sh

set -e
set -u

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

error() {
  printf "ERROR: %s\n" "$1" >&2
  exit 1
}

# Standard build
build() {
  echo "Starting standard build..."
  ninja -C build update || error "Failed to update build"
  ninja -C build quake3e || error "Failed to build quake3e"
  ninja -C build quake3e-openarena || error "Failed to build quake3e-openarena"
  ninja -C build quake3e-urbanterror || error "Failed to build quake3e-urbanterror"
  ninja -C build xonotic || error "Failed to build xonotic"
  ninja -C build ffmpeg || error "Failed to build ffmpeg"
  ninja -C build mpv || error "Failed to build mpv"
  echo "Standard build complete."
}

# Clean build
cleanbuild() {
  echo "Starting full build with clean..."
  ninja -C build clean || error "Failed to clean build"
  ninja -C build llvm || error "Failed to build llvm"
  build
  echo "Full build complete."
}

# Copy package contents in place.
package() {
  echo "Packaging contents..."
  (
    cd bin || error "Cannot enter bin directory"
    rm -f ./*.7z || true # Ignore if no files match
    find . -type f \( -name '*.exe' -o -name '*.com' -o -name '*.dll' \) -delete
    cp -r ../build/packages/*-package . || error "Failed to copy packages"
  ) || error "Packaging failed"
  echo "Packaging complete."
}

# Create package archives
archive() {
  echo "Creating archives..."

  PACKAGES="ffmpeg ffmpeg-full mpv quake3e quake3e-openarena quake3e-urbanterror xonotic"

  for pkg in $PACKAGES; do
    pkg_dir="${pkg}-package"
    archive_name="${pkg}.7z"

    if [ ! -d "bin/$pkg_dir" ]; then
      echo "Warning: Directory bin/$pkg_dir not found, skipping $pkg"
      continue
    fi

    (
      cd "bin/$pkg_dir" || error "Cannot enter $pkg_dir"
      7z a -mx=1 "../$archive_name" -- ./* || error "Failed to create $archive_name"
    ) || error "Failed to archive $pkg"
  done
  echo "Archives created in bin/."
}

# Clean a specific package
rmpkg() {
  pkg_name="$1"
  rm -rfv "build/packages/${pkg_name}-"* || error "Failed to rmpkg $pkg_name"
}

# Run update checking script
checkupdates() {
  sh ./packages/update-check.sh | column -t || error "Update check script failed"
}

# Menu
case "${1:-}" in
  "build")
    build
    ;;
  "cleanbuild")
    cleanbuild
    ;;
  "package")
    package
    ;;
  "archive")
    archive
    ;;
  "rmpkg")
    rmpkg "$2"
    ;;
  "checkupdates")
    checkupdates
    ;;
  *)
    echo "Usage: $0 {build|cleanbuild|package|archive|rmpkg <pkg>|checkupdates}"
    exit 1
    ;;
esac
