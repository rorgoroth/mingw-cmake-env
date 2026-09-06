#!/bin/sh
export LC_NUMERIC="C"

check() {
    if ! printf "%s\n%s\n" "$b" "$a" | sort -cV >/dev/null 2>&1; then
        echo "$pkg: $a -> $b [NEW]"
    else
        echo "$pkg: $a -> $b"
    fi
}

# brotli
pkg=brotli
a=$(cat ./packages/brotli.cmake | sed -n 's,.*v\([0-9][^"]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/google/brotli.git' | sed -n 's,.*refs/tags/v\([0-9][0-9.]*\)$,\1,p' | sort -Vr | head -1)
check

# curl
pkg=curl
a=$(cat ./packages/curl.cmake | sed -n 's,.*curl-\([0-9][^"]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/curl/curl.git' | sed -n 's,.*refs/tags/curl-\([0-9_]*\)$,\1,p' | tr '_' '.' | sort -Vr | head -1)
check

# expat
pkg=expat
a=$(cat ./packages/expat.cmake | sed -n 's,.*expat-\([0-9][^"]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/libexpat/libexpat.git' | sed -n 's,.*refs/tags/R_\([0-9_]*\)$,\1,p' | tr '_' '.' | sort -Vr | head -1)
check

# fontconfig
pkg=fontconfig
a=$(cat ./packages/fontconfig.cmake | sed -n 's,.*fontconfig-\([0-9][^"]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://gitlab.freedesktop.org/fontconfig/fontconfig/-/tags' | sed -n 's,.*/\([0-9][^"]*\)\.tar.*,\1,p' | sed 's:/[^/]*$::' | sort -Vr | head -1)
check

# harfbuzz
pkg=harfbuzz
a=$(cat ./packages/harfbuzz.cmake | grep tags | sed -n 's,.*tags/\([0-9][^"]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/harfbuzz/harfbuzz.git' | sed -n 's,.*refs/tags/\([0-9][0-9.]*\)$,\1,p' | sort -Vr | head -1)
check

# highway
pkg=highway
a=$(cat ./packages/highway.cmake | grep highway- | sed -n 's,.*highway-\([0-9][^"]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/google/highway.git' | sed -n 's,.*refs/tags/\([0-9][0-9.]*\)$,\1,p' | sort -Vr | head -1)
check

# libiconv
pkg=libiconv
a=$(cat ./packages/libiconv.cmake | grep 'libiconv-' | sed -n 's,.*libiconv-\([0-9][^>]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://www.gnu.org/software/libiconv/' | grep 'libiconv-' | sed -n 's,.*libiconv-\([0-9][^>]*\)\.tar.*,\1,p' | sort -Vr | head -1)
check

# libjxl
pkg=libjxl
a=$(cat ./packages/libjxl.cmake | sed -n 's,.*v\([0-9][^"]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/libjxl/libjxl.git' | sed -n 's,.*refs/tags/v\([0-9][0-9.]*\)$,\1,p' | sort -Vr | head -1)
check

# sdl2
pkg=sdl2
a=$(cat ./packages/sdl2.cmake | grep 'release-' | sed -n 's,.*release-\([0-9][^>]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/libsdl-org/SDL.git' | sed -n 's,.*refs/tags/release-\([0-9][^^]*\)$,\1,p' | grep '^2\.' | sort -Vr | head -1)
check

# sdl3
pkg=sdl3
a=$(cat ./packages/sdl3.cmake | grep 'release-' | sed -n 's,.*release-\([0-9.]*\)/.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/libsdl-org/SDL.git' | sed -n 's,.*refs/tags/release-\([0-9][0-9.]*\)$,\1,p' | grep '^3\.' | sort -Vr | head -1)
check

# libxml2
pkg=libxml2
a=$(cat ./packages/libxml2.cmake | grep 'libxml2' | sed -n 's,.*v\([0-9][^>]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/GNOME/libxml2.git' | sed -n 's,.*refs/tags/v\([0-9][0-9.]*\)$,\1,p' | sort -Vr | head -1)
check

# mujs
pkg=mujs
a=$(cat ./packages/mujs.cmake | grep 'mujs' | sed -n 's,.*/\([0-9][^>]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://codeberg.org/ccxvii/mujs/tags' | grep 'href="/ccxvii/mujs/archive/' | sed -n 's,.*href="/ccxvii/mujs/archive/\([0-9][^"_]*\)\.tar.*,\1,p' | sort -Vr | head -1)
check

# opus
pkg=opus
a=$(cat ./packages/opus.cmake | sed -n 's,.*opus-\([0-9][^"]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://ftp.osuosl.org/pub/xiph/releases/opus/?C=N;O=A' | sed -n 's,.*opus-\([0-9][^"]*\)\.tar.*,\1,p' | sort -Vr | head -1)
check

# rubberband
pkg=rubberband
a=$(cat ./packages/rubberband.cmake | sed -n 's,.*v\([0-9][^"]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/breakfastquay/rubberband.git' | sed -n 's,.*refs/tags/v\([0-9][0-9.]*\)$,\1,p' | sort -Vr | head -1)
check

# vulkan-headers
pkg=vulkan-headers
a=$(cat ./packages/vulkan-headers.cmake | grep 'Vulkan-Headers' | sed -n 's,.*v\([0-9][^>]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/KhronosGroup/Vulkan-Headers.git' | sed -n 's,.*refs/tags/v\([0-9][0-9.]*\)$,\1,p' | sort -Vr | head -1)
check

# vulkan-loader
pkg=vulkan-loader
a=$(cat ./packages/vulkan-loader.cmake | grep 'Vulkan-Loader' | sed -n 's,.*v\([0-9][^>]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/KhronosGroup/Vulkan-Loader.git' | sed -n 's,.*refs/tags/v\([0-9][0-9.]*\)$,\1,p' | sort -Vr | head -1)
check

# zlib
pkg=zlib
a=$(cat ./packages/zlib.cmake | grep 'zlib-ng' | sed -n 's,.*/\([0-9][^>]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/zlib-ng/zlib-ng.git' | sed -n 's,.*refs/tags/\([0-9][0-9.]*\)$,\1,p' | sort -Vr | head -1)
check

# zstd
pkg=zstd
a=$(cat ./packages/zstd.cmake | grep 'zstd' | sed -n 's,.*zstd-\([0-9][^>]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/facebook/zstd.git' | sed -n 's,.*refs/tags/v\([0-9][0-9.]*\)$,\1,p' | sort -Vr | head -1)
check