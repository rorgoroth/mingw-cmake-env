# About

This is a stripped down version of [shinchiro/mpv-winbuild-cmake](https://github.com/shinchiro/mpv-winbuild-cmake).

This is only tested on Alpine Linux and only 64bit Windows 10 and above is supported.

## Precompiled Packages

See the [Releases](https://github.com/rorgoroth/mingw-cmake-env/releases) page.

These all come with update scripts, however if one breaks it is on you to keep backups. In the event of breakage please check out the [Actions](https://github.com/rorgoroth/mingw-cmake-env/actions) and download the artifacts from a previous working build.

[FFmpeg](https://github.com/FFmpeg/FFmpeg): CLI tool for processing of video and audio files, git builds.

[mpv](https://github.com/mpv-player/mpv): Media player, git builds.

[OpenArena](https://github.com/rorgoroth/Quake3e-OpenArena): Completely FOSS version of Quake 3, client only (based on Quake3e using Vulkan), git builds.

[Quake2pro](https://github.com/skullernet/q2pro): Enhanced Quake 2 client and server focused on multiplayer, git builds.

[Quake3e](https://github.com/ec-/Quake3e): Quake3 optimized client using Vulkan, git builds.

[Urban Terror](https://github.com/omg-urt/urbanterror-slim): Quake3 mod and standalone game, client only (based on Quake3e, using Vulkan), git builds.

## Build Instructions

Basic build deps:

```bash
apk add -i 7zip autoconf automake bash clang llvm llvm-linker-tools lld cmake coreutils diffutils g++ gawk gcc gettext-dev git libtool make meson musl-dev nasm patch pkgconf po4a py3-mako samurai texinfo util-linux-misc yasm
```

Setup/Build:

```bash
git clone https://github.com/rorgoroth/mingw-cmake-env.git
cd mingw-cmake-env
ccmake -Bbuild -G Ninja
ninja -C build llvm
ninja -C build $package
```

Where `$package` is, for example, `mpv` -  by default all packages are built which is probably not what you want so specify the package you want, it also accepts multiple targets. The toolchain is excluded by default, so if there are updates to toolchain you need to manually run `ninja -C build llvm`.

The toolchain now uses precompiled clang/llvm from [rorgoroth/llvm-mingw](https://github.com/rorgoroth/llvm-mingw). The precompiled toolchain only works on Alpine, it will not work on Ubuntu or anything else. You'll need to build it yourself outside of Alpine. You should set up an Alpine container for this project.
