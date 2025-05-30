#!/bin/sh

# Standard build
build() {
  ninja -C build update || exit
  ninja -C build llvm || exit
  ninja -C build quake2pro || exit
  ninja -C build quake3e || exit
  ninja -C build quake3e-openarena || exit
  ninja -C build quake3e-urbanterror || exit
  ninja -C build xonotic || exit
  ninja -C build ffmpeg || exit
  ninja -C build mpv || exit
}

# Full build, clean up as much as possible. You should manually
# remove the installation prefix before running this as to create
# a clean environment.
fullbuild() {
  ninja -C build clean || exit
  ninja -C build update || exit
  ninja -C build llvm || exit
  ninja -C build quake2pro || exit
  ninja -C build quake3e || exit
  ninja -C build quake3e-openarena || exit
  ninja -C build quake3e-urbanterror || exit
  ninja -C build xonotic || exit
  ninja -C build ffmpeg || exit
  ninja -C build mpv || exit
}

# Copy package contents in place.
package() {
 cd bin || exit
   rm -rf ./*.7z
   find ./ -type f -name '*.exe' -delete
   find ./ -type f -name '*.com' -delete
   find ./ -type f -name '*.dll' -delete
   cp -r ../build/packages/*-package .
 cd .. || exit
}

# Create package archives
archive() {
  cd bin || exit
    cd ffmpeg-package || exit
        7z a -mx=1 "ffmpeg.7z" -- ./*
    cd .. || exit

    cd ffmpeg-full-package || exit
        7z a -mx=1 "ffmpeg-full.7z" -- ./*
    cd .. || exit

    cd mpv-package || exit
        7z a -mx=1 "mpv.7z" -- ./*
    cd .. || exit

    cd quake2pro-package || exit
        7z a -mx=1 "quake2pro.7z" -- ./*
    cd .. || exit

    cd quake3e-package || exit
        7z a -mx=1 "quake3e.7z" -- ./*
    cd .. || exit

    cd quake3e-openarena-package || exit
        7z a -mx=1 "quake3e-openarena.7z" -- ./*
    cd .. || exit

    cd quake3e-urbanterror-package || exit
        7z a -mx=1 "quake3e-urbanterror.7z" -- ./*
    cd .. || exit

    cd xonotic-package || exit
        7z a -mx=1 "xonotic.7z" -- ./*
    cd .. || exit

    mv -- */*.7z .
  cd .. || exit
}

# Upload packages
release() {
  gh release delete latest -y
  git tag --delete latest
  git push --delete origin latest
  gh release create -t "Latest Build" -n "Latest Build" latest ./bin/*.7z
}

# Clean a package, useful for random build failures.
clean() {
  rm -rf build/packages/"$2"-*
}

# Run update checking script
checkupdates() {
  sh ./packages/update-check.sh | column -t
}

case "$1" in
"build")
    build
    ;;
"fullbuild")
    fullbuild
    ;;
"package")
    package
    ;;
"archive")
    archive
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
    echo "Accepted Args: build | fullbuild | package | archive | release | clean \$package"
    exit 1
    ;;
esac
