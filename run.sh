#!/bin/sh

build () {
  cd build || exit
    ninja update && ninja || exit
    rm ../bin/*/*.exe
    rm ../bin/*/*.com
    rm ../bin/*/*.dll
    cp -rv packages/*-package ../bin
  cd .. || exit
}

package () {
  cd bin || exit
  rm -rf ./*.7z

  cd mpv-package || exit
  7za a "mpv-$(date +"%Y-%m-%d").7z" -- ./*
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

clean () {
  rm -rfv build/packages/"$2"-*
}

case "$1" in
  "build")
    build
    ;;
  "pkg")
    package
    ;;
  "clean")
    clean $@
    ;;
  *)
    echo "Accepted Args: build | pkg | clean "package""
    exit 1
    ;;
esac
