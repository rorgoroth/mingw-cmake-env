#!/bin/sh

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

# libiconv
iconv_local=$(cat ./packages/libiconv.cmake | grep 'libiconv-' | sed -n 's,.*libiconv-\([0-9][^>]*\)\.tar.*,\1,p')

iconv_remote=$(wget -q -O- 'https://www.gnu.org/software/libiconv/' | grep 'libiconv-' | sed -n 's,.*libiconv-\([0-9][^>]*\)\.tar.*,\1,p' | head -1)

echo "libiconv:"
echo "$iconv_local -> $iconv_remote"
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

