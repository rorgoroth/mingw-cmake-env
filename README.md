This is a stripped down version of [shinchiro/mpv-winbuild-cmake](https://github.com/shinchiro/mpv-winbuild-cmake).

This is only tested on Alpine, ran on WSL version 2.

The build system and produced binaries only support Windows 10+ and 64bit.

Binary Downloads (mpv, q3, iortcw, etc): [Here](https://drive.google.com/drive/folders/11TdCAm7zYMD_QK7xvkwBo-tb7ezs-cbD)

Basic build deps:
```
apk add -i autoconf automake cmake diffutils gcc g++ gettext-dev git gmp-dev gperf libtool make meson mpc1-dev mpfr-dev nasm ninja p7zip patch po4a py3-mako texinfo yasm
```

Setup/Build:
```
git clone https://github.com/rorgoroth/mingw-cmake-env.git
cd mingw-cmake-env
mkdir build && cd build
cmake -DTARGET_ARCH=x86_64-w64-mingw32 -G Ninja ..
ninja gcc
ninja
```
