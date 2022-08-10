#!/bin/sh

# gcc
gcc_local=$(cat ./toolchain/gcc-base.cmake | sed -n 's,.*gcc-\([0-9][^"]*\)\.tar.*,\1,p')
gcc_remote=$(wget -q -O- 'https://ftp.gnu.org/gnu/gcc/?C=M;O=D' | sed -n 's,.*<a href="gcc-\([0-9][^"]*\)/".*,\1,p' | sort -V | tail -1)
echo "gcc:"
echo "$gcc_local -> $gcc_remote"
echo

# mingw
mingw_local="10.0.0-git"
#mingw_local=$(cat ./toolchain/mingw-w64.cmake | sed -n 's,.*mingw-w64-\([0-9][^"]*\)\.tar.*,\1,p')
mingw_remote=$(wget -q -O- 'https://github.com/mingw-w64/mingw-w64/tags' | grep 'href="/mingw-w64/mingw-w64/archive/refs/tags' | sed -n 's,.*href="/mingw-w64/mingw-w64/archive/refs/tags/v\([0-9][^"_]*\)\.tar.*,\1,p' | head -1)
echo "mingw:"
echo "$mingw_local -> $mingw_remote"
echo

# binutils
binutils_local=$(cat ./toolchain/binutils.cmake | sed -n 's,.*binutils-\([0-9][^"]*\)\.tar.*,\1,p')
binutils_remote=$(wget -q -O- 'https://ftp.gnu.org/gnu/binutils/?C=M;O=D' | sed -n 's,.*<a href="binutils-\([0-9][^"]*\)\.tar.*,\1,p' | sort -V | tail -1)
echo "binutils:"
echo "$binutils_local -> $binutils_remote"
echo

# curl
curl_local=$(cat ./packages/curl.cmake | sed -n 's,.*curl-\([0-9][^"]*\)\.tar.*,\1,p')
curl_remote=$(wget -q -O- 'https://curl.haxx.se/download/?C=M;O=D' | sed -n 's,.*curl-\([0-9][^"]*\)\.tar.*,\1,p' | head -1)
echo "curl:"
echo "$curl_local -> $curl_remote"
echo

# expat
expat_local=$(cat ./packages/expat.cmake | sed -n 's,.*expat-\([0-9][^"]*\)\.tar.*,\1,p')
expat_remote=$(wget -q -O- 'https://github.com/libexpat/libexpat/releases' | sed -n 's,.*expat-\([0-9][^"]*\)\.tar.*,\1,p' | head -1)
echo "expat:"
echo "$expat_local -> $expat_remote"
echo

# gmp
gmp_local=$(cat ./packages/gmp.cmake | sed -n 's,.*gmp-\([0-9][^>]*\)\.tar.*,\1,p')
gmp_remote=$(wget -q -O- 'https://gmplib.org/' | grep '<a href="' | sed -n 's,.*gmp-\([0-9][^>]*\)\.tar.*,\1,p' | sort -V | tail -1)
echo "gmp:"
echo "$gmp_local -> $gmp_remote"
echo

# glew
glew_local=$(cat ./packages/glew.cmake | grep 'glew' | sed -n 's,.*glew-\([0-9][^>]*\)\.tgz,\1,p')
glew_remote=$(wget -q -O- 'https://github.com/nigels-com/glew/tags' | grep 'href="/nigels-com/glew/archive/refs/tags' | sed -n 's,.*href="/nigels-com/glew/archive/refs/tags/glew-\([0-9][^"_]*\)\.tar.*,\1,p' | head -1)
echo "glew:"
echo "$glew_local -> $glew_remote"
echo

# libiconv
iconv_local=$(cat ./packages/libiconv.cmake | grep 'libiconv-' | sed -n 's,.*libiconv-\([0-9][^>]*\)\.tar.*,\1,p')
iconv_remote=$(wget -q -O- 'https://www.gnu.org/software/libiconv/' | grep 'libiconv-' | sed -n 's,.*libiconv-\([0-9][^>]*\)\.tar.*,\1,p' | head -1)
echo "libiconv:"
echo "$iconv_local -> $iconv_remote"
echo

# libsdl2
libsdl2_local=$(cat ./packages/libsdl2.cmake | grep 'SDL2' | sed -n 's,.*SDL2-\([0-9][^>]*\)\.tar.*,\1,p')
libsdl2_remote=$(wget -q -O- 'https://github.com/libsdl-org/SDL/tags' | grep 'href="/libsdl-org/SDL/archive/refs/tags' | sed -n 's,.*href="/libsdl-org/SDL/archive/refs/tags/release-\([0-9][^"_]*\)\.tar.*,\1,p' | head -1)
echo "libsdl2:"
echo "$libsdl2_local -> $libsdl2_remote"
echo

# libvpx
libvpx_local=$(cat ./packages/libvpx.cmake | grep 'libvpx' | sed -n 's,.*v\([0-9][^>]*\)\.tar.*,\1,p')
libvpx_remote=$(wget -q -O- 'https://github.com/webmproject/libvpx/tags' | grep 'href="/webmproject/libvpx/archive/refs/tags' | sed -n 's,.*href="/webmproject/libvpx/archive/refs/tags/v\([0-9][^"_]*\)\.tar.*,\1,p' | head -1)
echo "libvpx:"
echo "$libvpx_local -> $libvpx_remote"
echo

# libwebp
libwebp_local=$(cat ./packages/libwebp.cmake | grep 'libwebp' | sed -n 's,.*v\([0-9][^>]*\)\.tar.*,\1,p')
libwebp_remote=$(wget -q -O- 'https://github.com/webmproject/libwebp/tags' | grep 'href="/webmproject/libwebp/archive/refs/tags' | sed -n 's,.*href="/webmproject/libwebp/archive/refs/tags/v\([0-9][^"_]*\)\.tar.*,\1,p' | head -1)
echo "libwebp:"
echo "$libwebp_local -> $libwebp_remote"
echo

# libzimg
libzimg_local=$(cat ./packages/libzimg.cmake | grep 'zimg' | sed -n 's,.*release-\([0-9][^>]*\)\.tar.*,\1,p')
libzimg_remote=$(wget -q -O- 'https://github.com/sekrit-twc/zimg/tags' | grep 'href="/sekrit-twc/zimg/archive/refs/tags/release' | sed -n 's,.*href="/sekrit-twc/zimg/archive/refs/tags/release-\([0-9][^"_]*\)\.tar.*,\1,p' | head -1)
echo "libzimg:"
echo "$libzimg_local -> $libzimg_remote"
echo

# vulkan-headers
vulkan_headers_local=$(cat ./packages/vulkan-headers.cmake | grep 'Vulkan-Headers' | sed -n 's,.*v\([0-9][^>]*\)\.tar.*,\1,p')
vulkan_headers_remote=$(wget -q -O- 'https://github.com/KhronosGroup/Vulkan-Headers/tags' | grep 'href="/KhronosGroup/Vulkan-Headers/archive/refs/tags' | sed -n 's,.*href="/KhronosGroup/Vulkan-Headers/archive/refs/tags/v\([0-9][^"_]*\)\.tar.*,\1,p' | head -1)
echo "Vulkan-Headers:"
echo "$vulkan_headers_local -> $vulkan_headers_remote"
echo

# vulkan-loader
vulkan_loader_local=$(cat ./packages/vulkan-loader.cmake | grep 'Vulkan-Loader' | sed -n 's,.*v\([0-9][^>]*\)\.tar.*,\1,p')
vulkan_loader_remote=$(wget -q -O- 'https://github.com/KhronosGroup/Vulkan-Loader/tags' | grep 'href="/KhronosGroup/Vulkan-Loader/archive/refs/tags' | sed -n 's,.*href="/KhronosGroup/Vulkan-Loader/archive/refs/tags/v\([0-9][^"_]*\)\.tar.*,\1,p' | head -1)
echo "Vulkan-Loader:"
echo "$vulkan_loader_local -> $vulkan_loader_remote"
echo

