#!/bin/sh

build () {
  cd build || exit
    ninja update && ninja -j1 || exit
    find ../bin/ -type f -name '*.exe' -delete
    find ../bin/ -type f -name '*.com' -delete
    find ../bin/ -type f -name '*.dll' -delete
    cp -r packages/*-package ../bin
  cd .. || exit
}

fullbuild () {
  cd build || exit
    ninja update || exit
    ninja clean || exit 
    ninja -j1 || exit
    find ../bin/ -type f -name '*.exe' -delete
    find ../bin/ -type f -name '*.com' -delete
    find ../bin/ -type f -name '*.dll' -delete
    cp -r packages/*-package ../bin
  cd .. || exit
}

clean () {
  rm -rfv build/packages/"$2"-*
}

package () {
  cd bin || exit
  rm -rf ./*.7z

  cd mpv-package || exit
  7za a "mpv-$(date +"%Y-%m-%d").7z" -- ./*
  cd .. || exit

  cd iortcw-package || exit
  7za a "iortcw-$(date +"%Y-%m-%d").7z" -- ./*
  cd .. || exit

  cd quake3e-package || exit
  7za a "quake3e-$(date +"%Y-%m-%d").7z" -- ./*
  cd .. || exit

  cd quake3e-urt-package || exit
  7za a "quake3e-urt-$(date +"%Y-%m-%d").7z" -- ./*
  cd .. || exit

  mv -- */*.7z .

  cd .. || exit
}

case "$1" in
  "build")
    build
    ;;
  "fullbuild")
    fullbuild
    ;;
  "pkg")
    package
    ;;
  "clean")
    clean $@
    ;;
  *)
    echo "Accepted Args: build | fullbuild | pkg | clean "package""
    exit 1
    ;;
esac
