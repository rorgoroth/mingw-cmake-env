#!/bin/sh

# Standard build
build () {
  cd build || exit
    ninja update && ninja -j1 || exit
    find ../bin/ -type f -name '*.exe' -delete
    find ../bin/ -type f -name '*.com' -delete
    find ../bin/ -type f -name '*.dll' -delete
    cp -r packages/*-package ../bin
  cd .. || exit
}

# Full build, clean up as much as possible. You should manually
# remove the installation prefix before running this as to create
# a clean environment.
fullbuild () {
  cd build || exit
    find toolchain/*-prefix/src/*-stamp/ -maxdepth 1 -type f ! -iname "*.cmake" -size 0c -delete
    find packages/*-prefix/src/*-stamp/ -maxdepth 1 -type f ! -iname "*.cmake" -size 0c -delete
    ninja update || exit
    ninja clean || exit
    ninja gcc || exit
    ninja || exit
    find ../bin/ -type f -name '*.exe' -delete
    find ../bin/ -type f -name '*.com' -delete
    find ../bin/ -type f -name '*.dll' -delete
    cp -r packages/*-package ../bin
  cd .. || exit
}

# Create the 7z packages.
package () {
  cd bin || exit
    rm -rf ./*.7z

  cd mpv-package || exit
    7za a "mpv.7z" -- ./*
  cd .. || exit

  cd ffmpeg-package || exit
    7za a "ffmpeg.7z" -- ./*
  cd .. || exit

  cd iortcw-package || exit
    7za a "iortcw.7z" -- ./*
  cd .. || exit

  cd quake3e-package || exit
    7za a "quake3e.7z" -- ./*
  cd .. || exit

  cd quake3e-urbanterror-package || exit
    7za a "quake3e-urbanterror.7z" -- ./*
  cd .. || exit

  cd quake3e-openarena-package || exit
    7za a "quake3e-openarena.7z" -- ./*
  cd .. || exit

  mv -- */*.7z .

  cd .. || exit
}

# Upload packages
release (){
  gh release delete latest -y
  git tag --delete latest
  git push --delete origin latest
  gh release create -t "Latest Build" -n "Latest Build" latest ./bin/*.7z
}

# Clean a package, useful for random build failures.
clean () {
  rm -rf build/packages/"$2"-*
}

# Run update checking script
checkupdates (){
  sh ./packages/update-check.sh | column -t
}

case "$1" in
  "build")
    build
    ;;
  "fbuild")
    fullbuild
    ;;
  "pkg")
    package
    ;;
  "release")
    release
    ;;
  "clean")
    clean $@
    ;;
  "checkupdates")
    checkupdates
    ;;
  *)
    echo "Accepted Args: build | fullbuild | pkg | release | clean \$package"
    exit 1
    ;;
esac
