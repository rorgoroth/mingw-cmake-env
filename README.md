This is a stripped down version of [shinchiro/mpv-winbuild-cmake](https://github.com/shinchiro/mpv-winbuild-cmake).

Leave me alone.

This is only tested on Alpine run on WSL version 2.

Basic build deps:
```
apk add -i autoconf cmake diffutils gcc gettext-dev git gmp-dev meson mpc1-dev mpfr-dev nasm ninja po4a py3-mako yasm
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

NOTE: GCC is built with default tune as native, change the build file from native --> generic if you intend to build binaries to distribute.
