# About

This is a stripped down version of [shinchiro/mpv-winbuild-cmake](https://github.com/shinchiro/mpv-winbuild-cmake).

This is only tested on Alpine Linux (Edge branch) ran on WSL version 2.

Only 64bit Windows 10 is supported and the produced binaries target x86-64-v3 architecture, which is pretty much any CPU made in the past 5 or so years.

## Binary Downloads

See the [Releases](https://github.com/rorgoroth/mingw-cmake-env/releases) page.

## Precompiled Packages

[mpv](https://github.com/mpv-player/mpv): Media player, git builds.

[FFmpeg](https://github.com/FFmpeg/FFmpeg): CLI tool for processing of video and audio files, git builds.

[Quake3e](https://github.com/ec-/Quake3e): Quake3 optimized client using Vulkan, git builds.

[OpenArena](https://github.com/rorgoroth/Quake3e-OpenArena): Completely FOSS version of Quake 3, client only (based on Quake3e using Vulkan), git builds.

[Urban Terror](https://github.com/omg-urt/urbanterror-slim): Quake3 mod and standalone game, client only (based on Quake3e, using Vulkan), git builds.

[ioRTcW](https://github.com/iortcw/iortcw): Open source client for RTCW single and multiplayer, client only, git builds.

[xonotic](https://github.com/rorgoroth/darkplaces-mingw-w64): Client only, git builds.

## Build Instructions

Basic build deps:

```bash
apk add -i autoconf automake cmake diffutils gcc g++ gettext-dev git gmp-dev gperf libtool make meson mpc1-dev mpfr-dev nasm ninja p7zip patch po4a py3-mako texinfo yasm
```

Setup/Build:

```bash
git clone https://github.com/rorgoroth/mingw-cmake-env.git
cd mingw-cmake-env
mkdir build && cd build
cmake -G Ninja ..
ninja gcc
ninja
```
