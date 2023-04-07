#!/bin/sh

# binutils
a=$(cat ./toolchain/binutils.cmake | sed -n 's,.*binutils-\([0-9][^"]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://ftp.gnu.org/gnu/binutils/?C=M;O=D' | sed -n 's,.*<a href="binutils-\([0-9][^"]*\)\.tar.*,\1,p' | sort -V | tail -1)
echo "binutils: $a -> $b"

# curl
a=$(cat ./packages/curl.cmake | sed -n 's,.*curl-\([0-9][^"]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://curl.haxx.se/download/?C=M;O=D' | sed -n 's,.*curl-\([0-9][^"]*\)\.tar.*,\1,p' | head -1)
echo "curl: $a -> $b"

# expat
a=$(cat ./packages/expat.cmake | sed -n 's,.*expat-\([0-9][^"]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://github.com/libexpat/libexpat/tags' | sed -n 's,.*R_\([0-9][^"]*\)\.tar.*,\1,p' | head -1)
echo "expat: $a -> $b"

# gmp
a=$(cat ./packages/gmp.cmake | sed -n 's,.*gmp-\([0-9][^>]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://gmplib.org/' | grep '<a href="' | sed -n 's,.*gmp-\([0-9][^>]*\)\.tar.*,\1,p' | sort -V | tail -1)
echo "gmp: $a -> $b"

# glew
a=$(cat ./packages/glew.cmake | grep 'glew' | sed -n 's,.*glew-\([0-9][^>]*\)\.tgz,\1,p')
b=$(wget -q -O- 'https://github.com/nigels-com/glew/tags' | grep 'href="/nigels-com/glew/archive/refs/tags' | sed -n 's,.*href="/nigels-com/glew/archive/refs/tags/glew-\([0-9][^"_]*\)\.tar.*,\1,p' | head -1)
echo "glew: $a -> $b"

# libiconv
a=$(cat ./packages/libiconv.cmake | grep 'libiconv-' | sed -n 's,.*libiconv-\([0-9][^>]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://www.gnu.org/software/libiconv/' | grep 'libiconv-' | sed -n 's,.*libiconv-\([0-9][^>]*\)\.tar.*,\1,p' | head -1)
echo "libiconv: $a -> $b"

# libsdl2
a=$(cat ./packages/libsdl2.cmake | grep 'SDL2' | sed -n 's,.*SDL2-\([0-9][^>]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://github.com/libsdl-org/SDL/tags' | grep 'href="/libsdl-org/SDL/archive/refs/tags' | sed -n 's,.*href="/libsdl-org/SDL/archive/refs/tags/release-\([0-9][^"_]*\)\.tar.*,\1,p' | head -1)
echo "libsdl2: $a -> $b"

# libzimg
a=$(cat ./packages/libzimg.cmake | grep 'zimg' | sed -n 's,.*release-\([0-9][^>]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://github.com/sekrit-twc/zimg/tags' | grep 'href="/sekrit-twc/zimg/archive/refs/tags/release' | sed -n 's,.*href="/sekrit-twc/zimg/archive/refs/tags/release-\([0-9][^"_]*\)\.tar.*,\1,p' | head -1)
echo "libzimg: $a -> $b"

# rubberband
a=$(cat ./packages/rubberband.cmake | sed -n 's,.*v\([0-9][^"]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://github.com/breakfastquay/rubberband/tags' | sed -n 's,.*v\([0-9][^"]*\)\.tar.*,\1,p' | head -1)
echo "rubberband: $a -> $b"

# vulkan-headers
a=$(cat ./packages/vulkan-headers.cmake | grep 'Vulkan-Headers' | sed -n 's,.*v\([0-9][^>]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://github.com/KhronosGroup/Vulkan-Headers/tags' | grep 'href="/KhronosGroup/Vulkan-Headers/archive/refs/tags' | sed -n 's,.*href="/KhronosGroup/Vulkan-Headers/archive/refs/tags/v\([0-9][^"_]*\)\.tar.*,\1,p' | head -1)
echo "vulkan-headers: $a -> $b"

# vulkan-loader
a=$(cat ./packages/vulkan-loader.cmake | grep 'Vulkan-Loader' | sed -n 's,.*v\([0-9][^>]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://github.com/KhronosGroup/Vulkan-Loader/tags' | grep 'href="/KhronosGroup/Vulkan-Loader/archive/refs/tags' | sed -n 's,.*href="/KhronosGroup/Vulkan-Loader/archive/refs/tags/v\([0-9][^"_]*\)\.tar.*,\1,p' | head -1)
echo "vulkan-loader: $a -> $b"

# zstd
a=$(cat ./packages/zstd.cmake | grep 'zstd' | sed -n 's,.*zstd-\([0-9][^>]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://github.com/facebook/zstd/tags' | sed -n 's,.*v\([0-9][^"]*\)\.tar.*,\1,p' | sort -Vr | head -1)
echo "zstd: $a -> $b"
