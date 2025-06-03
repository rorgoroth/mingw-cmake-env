#!/bin/sh
export LC_NUMERIC="C"

check() {
if ! printf "%s\n%s\n" "$b" "$a" | sort -cV &> /dev/null ; then
        echo "$pkg: $a -> $b [NEW]"
    else
        echo "$pkg: $a -> $b"
fi
}

# brotli
pkg=brotli
a=$(cat ./packages/brotli.cmake | sed -n 's,.*v\([0-9][^"]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://github.com/google/brotli/tags' | sed -n 's,.*v\([0-9][^"]*\)\.tar.*,\1,p' | head -1 | sed 's/\_/\./g')
check

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

# glew
#pkg=glew
#a=$(cat ./packages/glew.cmake | grep 'glew' | sed -n 's,.*glew-\([0-9][^>]*\)\.tgz,\1,p')
#b=$(wget -q -O- 'https://github.com/nigels-com/glew/tags' | grep 'href="/nigels-com/glew/archive/refs/tags' | sed -n 's,.*href="/nigels-com/glew/archive/refs/tags/glew-\([0-9][^"_]*\)\.tar.*,\1,p' | head -1)
#check

# highway
pkg=highway
a=$(cat ./packages/highway.cmake | grep highway- | sed -n 's,.*highway-\([0-9][^"]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://github.com/google/highway/tags' | sed -n 's,.*/\([0-9][^"]*\)\.tar.*,\1,p' | head -1 | sed 's/\_/\./g')
check

# libiconv
pkg=libiconv
a=$(cat ./packages/libiconv.cmake | grep 'libiconv-' | sed -n 's,.*libiconv-\([0-9][^>]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://www.gnu.org/software/libiconv/' | grep 'libiconv-' | sed -n 's,.*libiconv-\([0-9][^>]*\)\.tar.*,\1,p' | head -1)
check

# libjxl
pkg=libjxl
a=$(cat ./packages/libjxl.cmake | sed -n 's,.*v\([0-9][^"]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://github.com/libjxl/libjxl/tags' | sed -n 's,.*v\([0-9][^"]*\)\.tar.*,\1,p' | sort -Vr | head -1 | sed 's/\_/\./g')
check

# libplacebo
pkg=libplacebo
a=$(cat ./packages/libplacebo.cmake | sed -n 's,.*v\([0-9][^"]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://github.com/haasn/libplacebo/tags' | sed -n 's,.*v\([0-9][^"]*\)\.tar.*,\1,p' | sort -Vr | head -1)
check

# libsdl2
pkg=libsdl2
a=$(cat ./packages/libsdl2.cmake | grep 'SDL2' | sed -n 's,.*SDL2-\([0-9][^>]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://github.com/libsdl-org/SDL/tags' | grep 'href="/libsdl-org/SDL/archive/refs/tags' | grep 'release-2' | sed -n 's,.*href="/libsdl-org/SDL/archive/refs/tags/release-\([0-9][^"_]*\)\.tar.*,\1,p' | head -1)
check

# libxml2
pkg=libxml2
a=$(cat ./packages/libxml2.cmake | grep 'libxml2' | sed -n 's,.*v\([0-9][^>]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://github.com/GNOME/libxml2/tags' | grep 'href="/GNOME/libxml2/archive/refs/tags' | sed -n 's,.*href="/GNOME/libxml2/archive/refs/tags/v\([0-9][^"_]*\)\.tar.*,\1,p' | head -1)
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
b=$(wget -q -O- 'https://ftp.osuosl.org/pub/xiph/releases/opus/?C=N;O=A' | sed -n 's,.*opus-\([0-9][^"]*\)\.tar.*,\1,p' | sort -Vr | head -1)
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
