#!/bin/sh
export LC_NUMERIC="C"

check() {
    if awk "BEGIN {exit !($b > $a)}"; then
        echo "$pkg: $a -> $b [NEW]"
    else
        echo "$pkg: $a -> $b"
    fi
}

# curl
pkg=curl
a=$(cat ./packages/curl.cmake | sed -n 's,.*curl-\([0-9][^"]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://curl.haxx.se/download/?C=M;O=D' | sed -n 's,.*curl-\([0-9][^"]*\)\.tar.*,\1,p' | head -1)
check

# expat
pkg=expat
a=$(cat ./packages/expat.cmake | sed -n 's,.*expat-\([0-9][^"]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://github.com/libexpat/libexpat/tags' | sed -n 's,.*R_\([0-9][^"]*\)\.tar.*,\1,p' | head -1 | sed 's/\_/\./g')
check

# gmp
pkg=gmp
a=$(cat ./packages/gmp.cmake | sed -n 's,.*gmp-\([0-9][^>]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://gmplib.org/' | grep '<a href="' | sed -n 's,.*gmp-\([0-9][^>]*\)\.tar.*,\1,p' | sort -V | tail -1)
check

# glew
#pkg=glew
#a=$(cat ./packages/glew.cmake | grep 'glew' | sed -n 's,.*glew-\([0-9][^>]*\)\.tgz,\1,p')
#b=$(wget -q -O- 'https://github.com/nigels-com/glew/tags' | grep 'href="/nigels-com/glew/archive/refs/tags' | sed -n 's,.*href="/nigels-com/glew/archive/refs/tags/glew-\([0-9][^"_]*\)\.tar.*,\1,p' | head -1)
#check

# libiconv
pkg=libiconv
a=$(cat ./packages/libiconv.cmake | grep 'libiconv-' | sed -n 's,.*libiconv-\([0-9][^>]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://www.gnu.org/software/libiconv/' | grep 'libiconv-' | sed -n 's,.*libiconv-\([0-9][^>]*\)\.tar.*,\1,p' | head -1)
check

# libsdl2
pkg=libsdl2
a=$(cat ./packages/libsdl2.cmake | grep 'SDL2' | sed -n 's,.*SDL2-\([0-9][^>]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://github.com/libsdl-org/SDL/tags' | grep 'href="/libsdl-org/SDL/archive/refs/tags' | sed -n 's,.*href="/libsdl-org/SDL/archive/refs/tags/release-\([0-9][^"_]*\)\.tar.*,\1,p' | head -1)
check

# libzimg
pkg=libzimg
a=$(cat ./packages/libzimg.cmake | grep 'zimg' | sed -n 's,.*release-\([0-9][^>]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://github.com/sekrit-twc/zimg/tags' | grep 'href="/sekrit-twc/zimg/archive/refs/tags/release' | sed -n 's,.*href="/sekrit-twc/zimg/archive/refs/tags/release-\([0-9][^"_]*\)\.tar.*,\1,p' | head -1)
check

# mujs
pkg=mujs
a=$(cat ./packages/mujs.cmake | grep 'mujs' | sed -n 's,.*/\([0-9][^>]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://github.com/ccxvii/mujs/tags' | grep 'href="/ccxvii/mujs/archive/refs/tags' | sed -n 's,.*href="/ccxvii/mujs/archive/refs/tags/\([0-9][^"_]*\)\.tar.*,\1,p' | head -1)
check

# openal
pkg=openal
a=$(cat ./packages/openal.cmake | grep 'openal' | sed -n 's,.*/\([0-9][^>]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://github.com/kcat/openal-soft/tags' | grep 'href="/kcat/openal-soft/archive/refs/tags' | sed -n 's,.*href="/kcat/openal-soft/archive/refs/tags/\([0-9][^"_]*\)\.tar.*,\1,p' | head -1)
check

# opus
pkg=opus
a=$(cat ./packages/opus.cmake | sed -n 's,.*opus-\([0-9][^"]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://ftp.osuosl.org/pub/xiph/releases/opus/?C=N;O=A' | sed -n 's,.*opus-\([0-9][^"]*\)\.tar.*,\1,p' | sort -r | head -1)
check

# rubberband
pkg=rubberband
a=$(cat ./packages/rubberband.cmake | sed -n 's,.*v\([0-9][^"]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://github.com/breakfastquay/rubberband/tags' | sed -n 's,.*v\([0-9][^"]*\)\.tar.*,\1,p' | head -1)
check

# vulkan-headers
pkg=vulkan-headers
a=$(cat ./packages/vulkan-headers.cmake | grep 'Vulkan-Headers' | sed -n 's,.*v\([0-9][^>]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://github.com/KhronosGroup/Vulkan-Headers/tags' | grep 'href="/KhronosGroup/Vulkan-Headers/archive/refs/tags' | sed -n 's,.*href="/KhronosGroup/Vulkan-Headers/archive/refs/tags/v\([0-9][^"_]*\)\.tar.*,\1,p' | head -1)
check

# vulkan-loader
pkg=vulkan-loader
a=$(cat ./packages/vulkan-loader.cmake | grep 'Vulkan-Loader' | sed -n 's,.*v\([0-9][^>]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://github.com/KhronosGroup/Vulkan-Loader/tags' | grep 'href="/KhronosGroup/Vulkan-Loader/archive/refs/tags' | sed -n 's,.*href="/KhronosGroup/Vulkan-Loader/archive/refs/tags/v\([0-9][^"_]*\)\.tar.*,\1,p' | head -1)
check

# zlib
pkg=zlib
a=$(cat ./packages/zlib.cmake | grep 'zlib-ng' | sed -n 's,.*/\([0-9][^>]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://github.com/zlib-ng/zlib-ng/tags' | grep 'href="/zlib-ng/zlib-ng/archive/refs/tags' | sed -n 's,.*href="/zlib-ng/zlib-ng/archive/refs/tags/\([0-9][^"_]*\)\.tar.*,\1,p' | head -1)
check

# zstd
pkg=zstd
a=$(cat ./packages/zstd.cmake | grep 'zstd' | sed -n 's,.*zstd-\([0-9][^>]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://github.com/facebook/zstd/tags' | sed -n 's,.*v\([0-9][^"]*\)\.tar.*,\1,p' | sort -Vr | head -1)
check
