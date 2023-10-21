# About

This is a stripped down version of [shinchiro/mpv-winbuild-cmake](https://github.com/shinchiro/mpv-winbuild-cmake).

This is only tested on Alpine Linux ran on WSL version 2 and only 64bit Windows 10 is supported.

## Binary Downloads

See the [Releases](https://github.com/rorgoroth/mingw-cmake-env/releases) page.

## Precompiled Packages

[FFmpeg](https://github.com/FFmpeg/FFmpeg): CLI tool for processing of video and audio files, git builds.

[mpv](https://github.com/mpv-player/mpv): Media player, git builds.

[OpenArena](https://github.com/rorgoroth/Quake3e-OpenArena): Completely FOSS version of Quake 3, client only (based on Quake3e using Vulkan), git builds.

[Quake2pro](https://github.com/skullernet/q2pro): Enhanced Quake 2 client and server focused on multiplayer, git builds.

[Quake3e](https://github.com/ec-/Quake3e): Quake3 optimized client using Vulkan, git builds.

[Urban Terror](https://github.com/omg-urt/urbanterror-slim): Quake3 mod and standalone game, client only (based on Quake3e, using Vulkan), git builds.

[xonotic](https://github.com/rorgoroth/darkplaces-mingw-w64): Client only, git builds.

## Build Instructions

Basic build deps:

```bash
apk add -i autoconf automake bash cmake diffutils g++ gcc git libtool make meson nasm p7zip patch pkgconf po4a py3-mako samurai texinfo yasm
```

Setup/Build:

```bash
git clone https://github.com/rorgoroth/mingw-cmake-env.git
cd mingw-cmake-env
mkdir build && cd build
ccmake -G Ninja ..
ninja llvm
ninja $package
```

Where `$package` is, for example, `mpv` -  by default all packages are built which is probably not what you want so specify the package you want, it also accepts multiple targets. The toolchain is also excluded by default, so if there are updates to toolchain you need to manually run `ninja llvm`.

The toolchain now uses precompiled llvm from [rorgoroth/llvm-mingw](https://github.com/rorgoroth/llvm-mingw), checkout `deprecated_gcc` branch for the old version which requires building gcc if you need it but I probably wont be updating anything on that branch in the future. The downside to this is that my precompiled toolchain is built on alpine for alpine, it will not work inside of Ubuntu or anything else. If you want to use it you can fork my llvm-mingw yourself, run build.sh then upload your own toolchain the your release page and edit llvm.cmake in the toolchain directory to point at yours. I know it's slightly annoying but having a precompiled toolchain makes full rebuilds and setting up environment so much quicker for me. You coud also just set up an alpine container for this project which is what I do anyway.