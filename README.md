This is a stripped down version of [shinchiro/mpv-winbuild-cmake](https://github.com/shinchiro/mpv-winbuild-cmake).

This is only tested on Alpine Linux (Edge branch with testing enabled) ran on WSL version 2.

Only 64bit Windows 10 is supported and the produced binaries target x86-64-v3 architecture, which is pretty much any CPU made in the past 5 or so years.

Binary Downloads (mpv, q3, urt, iortcw, etc): [Releases](https://github.com/rorgoroth/mingw-cmake-env/releases)

Basic build deps:
```
apk add -i autoconf automake cmake diffutils gcc g++ gettext-dev git gmp-dev gperf libtool make meson mpc1-dev mpfr-dev nasm ninja p7zip patch po4a py3-mako texinfo yasm
```

Setup/Build:
```
git clone https://github.com/rorgoroth/mingw-cmake-env.git
cd mingw-cmake-env
mkdir build && cd build
cmake -G Ninja ..
ninja gcc
ninja
```
