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
  ninja -C build update || error "Update Failed"
  ninja -C build fetch || error "Fetch Failed"
  ninja -C build || error "Build Failed"
  echo "Build Complete."
}

# Download, update and patch the sources of all packages in parallel
fetch() {
  echo "Fetching and patching package sources..."
  ninja -C build fetch || error "Failed to fetch sources"
  echo "Fetch Complete."
}

# Clean build
cleanbuild() {
  echo "Starting full build with clean..."
  ninja -C build clean || error "Failed to clean build"
  ninja -C build llvm || error "Failed to build llvm"
  build
  echo "Build Complete."
}

# Copy package contents in place.
package() {
  echo "Packaging contents..."
  (
    cd bin || error "Cannot enter bin directory"
    rm -f ./*.7z ./SHA256SUMS || true # Ignore if no files match
    find . -type f \( -name '*.exe' -o -name '*.com' -o -name '*.dll' \) -delete
    cp -r ../build/packages/*-package . || error "Failed to copy packages"
  ) || error "Packaging failed"
  echo "Packaging Complete."
}

# Create package archives
archive() {
  echo "Creating archives..."

  PACKAGES="ffmpeg ffmpeg-full librempeg mpv quake3e quake3e-urbanterror xonotic"

  for pkg in $PACKAGES; do
    pkg_dir="${pkg}-package"
    archive_name="${pkg}.7z"

    if [ ! -d "bin/$pkg_dir" ]; then
      echo "Warning: Directory bin/$pkg_dir not found, skipping $pkg"
      continue
    fi

    (
      cd "bin/$pkg_dir" || error "Cannot enter $pkg_dir"
      7z a -mx=9 "../$archive_name" -- ./* || error "Failed to create $archive_name"
    ) || error "Failed to archive $pkg"
  done

  (
    cd bin || error "Cannot enter bin directory"
    rm -f SHA256SUMS
    set -- ./*.7z
    [ -e "$1" ] || error "No archives found to checksum"
    sha256sum -- *.7z > SHA256SUMS || error "Failed to create SHA256SUMS"
  ) || error "Failed to checksum archives"
  echo "Archives and SHA256SUMS created in bin/."
}

# Clean a specific package.
rmpkg() {
  pkg_name="${1:-}"
  [ -n "$pkg_name" ] || error "rmpkg needs a package name"
  case "$pkg_name" in
    *[!A-Za-z0-9._+-]*) error "Invalid package name: $pkg_name" ;;
  esac
  [ -d "build/packages/${pkg_name}-prefix" ] || error "No such package: $pkg_name"
  rm -rfv "build/packages/${pkg_name}-prefix" || error "Failed to rmpkg $pkg_name"
}

# Run update checking script.
checkupdates() {
  out=$(mktemp) || error "Cannot create a temporary file"
  rc=0
  sh ./packages/update-check.sh > "$out" || rc=$?
  sed '/^$/,$d' "$out" | column -t
  sed -n '/^$/,$p' "$out"
  rm -f "$out"
  return "$rc"
}

# Menu
case "${1:-}" in
  "fetch")
    fetch
    ;;
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
    rmpkg "${2:-}"
    ;;
  "checkupdates")
    checkupdates
    ;;
  *)
    echo "Usage: $0 {fetch|build|cleanbuild|package|archive|rmpkg <pkg>|checkupdates}"
    exit 1
    ;;
esac
