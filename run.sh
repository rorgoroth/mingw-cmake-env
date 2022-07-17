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
    ninja gcc || exit
    ninja || exit
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

  cd ffmpeg-package || exit
    7za a "ffmpeg-$(date +"%Y-%m-%d").7z" -- ./*
  cd .. || exit

  cd iortcw-package || exit
    7za a "iortcw-$(date +"%Y-%m-%d").7z" -- ./*
  cd .. || exit

  cd quake3e-package || exit
    7za a "quake3e-$(date +"%Y-%m-%d").7z" -- ./*
  cd .. || exit

  cd quake3e-urt-slim-package || exit
    7za a "quake3e-urt-slim-$(date +"%Y-%m-%d").7z" -- ./*
  cd .. || exit

  mv -- */*.7z .

  cd .. || exit
}

release (){
  gh release delete latest -y
  git tag --delete latest
  git push --delete origin latest
  gh release create -t "Latest Build" -n "Latest Build" latest ./bin/*.7z
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
  "release")
    release
    ;;
  "clean")
    clean $@
    ;;
  *)
    echo "Accepted Args: build | fullbuild | pkg | release | clean \$package"
    exit 1
    ;;
esac
