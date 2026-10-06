#!/bin/sh
# Checks upstream for new releases of the packages listed below. When a newer
# version is found, the URL and URL_HASH in the package's .cmake file are
# rewritten in place (the new tarball is downloaded to work out the SHA256).
#
# Usage (from the repository root):
#   sh ./packages/update-check.sh      check and update
#   sh ./packages/update-check.sh -n   check only, don't touch any files
#
# vulkan-headers and vulkan-loader are checked but never updated, they are
# handled separately.
export LC_NUMERIC="C"

UPDATE=1
case "$1" in
    -n|--check-only) UPDATE=0 ;;
    -h|--help) echo "Usage: $0 [-n|--check-only]"; exit 0 ;;
esac

# finish the line left open by check()
endline() {
    printf '%s\n' "$*"
    open=0
}

# check [noupdate]: print the version line. For a [NEW] package that
# update() will handle, the line is left open so update() can append its
# result ([UPDATED], [FAILED ...]) to the same line.
check() {
    new=0
    updated=0
    open=0
    if ! printf "%s\n%s\n" "$b" "$a" | sort -cV >/dev/null 2>&1; then
        new=1
        printf '%s: %s -> %s [NEW]' "$pkg" "$a" "$b"
        if [ "$UPDATE" = 1 ] && [ "$1" != noupdate ]; then
            open=1
        else
            echo
        fi
    else
        echo "$pkg: $a -> $b"
    fi
}

# 1.2.3 -> 1_2_3
us() {
    printf '%s' "$1" | tr . _
}

# subst <string> <old> <new>: literal (non-regex) replace of every <old>
subst() {
    awk -v s="$1" -v o="$2" -v n="$3" 'BEGIN {
        out = ""
        while ((i = index(s, o)) > 0) {
            out = out substr(s, 1, i - 1) n
            s = substr(s, i + length(o))
        }
        print out s
    }'
}

# update <old> <new> [<old> <new> ...]
# Applies the literal substitutions to the URL in packages/$pkg.cmake,
# downloads the new tarball and rewrites URL and URL_HASH in the file.
# Does nothing unless check() flagged the package as [NEW]. The file is left
# untouched if anything goes wrong.
update() {
    updated=0
    if [ "$new" != 1 ] || [ "$UPDATE" != 1 ] || [ -z "$a" ] || [ -z "$b" ]; then
        [ "$open" = 1 ] && endline
        return 0
    fi

    file=./packages/$pkg.cmake
    old_url=$(sed -n 's,^[[:space:]]*URL[[:space:]][[:space:]]*\([^[:space:]]*\).*,\1,p' "$file" | head -1)
    new_url=$old_url
    while [ $# -ge 2 ]; do
        new_url=$(subst "$new_url" "$1" "$2")
        shift 2
    done
    if [ -z "$old_url" ] || [ "$new_url" = "$old_url" ]; then
        endline " [FAILED: could not work out the new URL]"
        return 1
    fi

    tmp=$(mktemp)
    if ! wget -q -O "$tmp" "$new_url" || [ ! -s "$tmp" ]; then
        rm -f "$tmp"
        endline " [FAILED: download failed] $new_url"
        return 1
    fi
    hash=$(sha256sum "$tmp" | cut -d' ' -f1)
    rm -f "$tmp"

    awk -v ou="$old_url" -v nu="$new_url" -v h="$hash" '
        /^[[:space:]]*URL[[:space:]]/ {
            i = index($0, ou)
            if (i) $0 = substr($0, 1, i - 1) nu substr($0, i + length(ou))
        }
        /^[[:space:]]*URL_HASH[[:space:]]/ { sub(/SHA256=[0-9a-fA-F]+/, "SHA256=" h) }
        { print }
    ' "$file" > "$file.new" && cat "$file.new" > "$file"
    rm -f "$file.new"

    updated=1
    status=" [UPDATED]"
    for p in ./packages/$pkg-*.patch; do
        [ -e "$p" ] && status="$status [CHECK PATCHES]" && break
    done
    endline "$status"
    return 0
}

# brotli
pkg=brotli
a=$(cat ./packages/brotli.cmake | sed -n 's,.*v\([0-9][^"]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/google/brotli.git' | sed -n 's,.*refs/tags/v\([0-9][0-9.]*\)$,\1,p' | sort -Vr | head -1)
check
update "v$a" "v$b"

# curl
pkg=curl
a=$(cat ./packages/curl.cmake | sed -n 's,.*curl-\([0-9][^"]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/curl/curl.git' | sed -n 's,.*refs/tags/curl-\([0-9_]*\)$,\1,p' | tr '_' '.' | sort -Vr | head -1)
check
update "curl-$(us "$a")" "curl-$(us "$b")" "curl-$a" "curl-$b"

# expat
pkg=expat
a=$(cat ./packages/expat.cmake | sed -n 's,.*expat-\([0-9][^"]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/libexpat/libexpat.git' | sed -n 's,.*refs/tags/R_\([0-9_]*\)$,\1,p' | tr '_' '.' | sort -Vr | head -1)
check
update "R_$(us "$a")" "R_$(us "$b")" "expat-$a" "expat-$b"

# fontconfig
pkg=fontconfig
a=$(cat ./packages/fontconfig.cmake | sed -n 's,.*fontconfig-\([0-9][^"]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://gitlab.freedesktop.org/fontconfig/fontconfig/-/tags' | sed -n 's,.*/\([0-9][^"]*\)\.tar.*,\1,p' | sed 's:/[^/]*$::' | sort -Vr | head -1)
check
update "$a" "$b"

# harfbuzz
pkg=harfbuzz
a=$(cat ./packages/harfbuzz.cmake | grep tags | sed -n 's,.*tags/\([0-9][^"]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/harfbuzz/harfbuzz.git' | sed -n 's,.*refs/tags/\([0-9][0-9.]*\)$,\1,p' | sort -Vr | head -1)
check
update "tags/$a" "tags/$b"

# highway
pkg=highway
a=$(cat ./packages/highway.cmake | grep highway- | sed -n 's,.*highway-\([0-9][^"]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/google/highway.git' | sed -n 's,.*refs/tags/\([0-9][0-9.]*\)$,\1,p' | sort -Vr | head -1)
check
update "$a" "$b"

# libiconv
pkg=libiconv
a=$(cat ./packages/libiconv.cmake | grep 'libiconv-' | sed -n 's,.*libiconv-\([0-9][^>]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://cdimage.debian.org/mirror/gnu.org/gnu/libiconv/' | grep -o 'libiconv-[0-9][0-9.]*\.tar\.gz' | sed -n 's,libiconv-\([0-9][0-9.]*\)\.tar\.gz,\1,p' | sort -Vr | head -1)
check
update "libiconv-$a" "libiconv-$b"

# libjxl
pkg=libjxl
a=$(cat ./packages/libjxl.cmake | sed -n 's,.*v\([0-9][^"]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/libjxl/libjxl.git' | sed -n 's,.*refs/tags/v\([0-9][0-9.]*\)$,\1,p' | sort -Vr | head -1)
check
update "v$a" "v$b"

# libunibreak
pkg=libunibreak
a=$(cat ./packages/libunibreak.cmake | sed -n 's,.*libunibreak_\([0-9][^"]*\)\.tar.*,\1,p' | tr '_' '.')
b=$(git ls-remote --tags 'https://github.com/adah1972/libunibreak.git' | sed -n 's,.*refs/tags/libunibreak_\([0-9_]*\)$,\1,p' | tr '_' '.' | sort -Vr | head -1)
check
update "libunibreak_$(us "$a")" "libunibreak_$(us "$b")"

# llvm (llvm-mingw-toolchain)
pkg=llvm
a=$(cat ./packages/llvm.cmake | sed -n 's,.*releases/download/\([0-9][^/]*\)/.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/rorgoroth/llvm-mingw-toolchain.git' | sed -n 's,.*refs/tags/\([0-9][0-9.]*\)$,\1,p' | sort -Vr | head -1)
check
update "$a" "$b"

# sdl2
pkg=sdl2
a=$(cat ./packages/sdl2.cmake | grep 'release-' | sed -n 's,.*release-\([0-9][^>]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/libsdl-org/SDL.git' | sed -n 's,.*refs/tags/release-\([0-9][^^]*\)$,\1,p' | grep '^2\.' | sort -Vr | head -1)
check
update "release-$a" "release-$b"

# sdl3
pkg=sdl3
a=$(cat ./packages/sdl3.cmake | grep 'release-' | sed -n 's,.*release-\([0-9.]*\)/.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/libsdl-org/SDL.git' | sed -n 's,.*refs/tags/release-\([0-9][0-9.]*\)$,\1,p' | grep '^3\.' | sort -Vr | head -1)
check
update "$a" "$b"

# libxml2
pkg=libxml2
a=$(cat ./packages/libxml2.cmake | grep 'libxml2' | sed -n 's,.*v\([0-9][^>]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/GNOME/libxml2.git' | sed -n 's,.*refs/tags/v\([0-9][0-9.]*\)$,\1,p' | sort -Vr | head -1)
check
update "v$a" "v$b"

# mujs
pkg=mujs
a=$(cat ./packages/mujs.cmake | grep 'mujs' | sed -n 's,.*/\([0-9][^>]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://codeberg.org/ccxvii/mujs/tags' | grep 'href="/ccxvii/mujs/archive/' | sed -n 's,.*href="/ccxvii/mujs/archive/\([0-9][^"_]*\)\.tar.*,\1,p' | sort -Vr | head -1)
check
update "/$a.tar" "/$b.tar"
[ "$updated" = 1 ] && sed -i "s/VERSION=$a\"/VERSION=$b\"/" ./packages/mujs.cmake

# opus
pkg=opus
a=$(cat ./packages/opus.cmake | sed -n 's,.*opus-\([0-9][^"]*\)\.tar.*,\1,p')
b=$(wget -q -O- 'https://ftp.osuosl.org/pub/xiph/releases/opus/?C=N;O=A' | sed -n 's,.*opus-\([0-9][^"]*\)\.tar.*,\1,p' | sort -Vr | head -1)
check
update "opus-$a" "opus-$b"

# rubberband
pkg=rubberband
a=$(cat ./packages/rubberband.cmake | sed -n 's,.*v\([0-9][^"]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/breakfastquay/rubberband.git' | sed -n 's,.*refs/tags/v\([0-9][0-9.]*\)$,\1,p' | sort -Vr | head -1)
check
update "v$a" "v$b"

# sqlite
pkg=sqlite
a=$(cat ./packages/sqlite.cmake | sed -n 's,.*sqlite-autoconf-\([0-9]*\)\.tar.*,\1,p')
page=$(wget -q -O- 'https://www.sqlite.org/download.html')
b=$(printf '%s\n' "$page" | sed -n 's,.*sqlite-autoconf-\([0-9]*\)\.tar.*,\1,p' | sort -Vr | head -1)
check
# the download URL contains the release year, which changes between versions
old_year=$(sed -n 's,.*/\([0-9]\{4\}\)/sqlite-autoconf-.*,\1,p' ./packages/sqlite.cmake | head -1)
new_year=$(printf '%s\n' "$page" | grep -o "[0-9]\{4\}/sqlite-autoconf-$b\.tar" | head -1 | cut -c1-4)
update "$old_year/sqlite-autoconf-$a" "$new_year/sqlite-autoconf-$b"
# vulkan-headers (check only, updated separately)
pkg=vulkan-headers
a=$(cat ./packages/vulkan-headers.cmake | grep 'Vulkan-Headers' | sed -n 's,.*v\([0-9][^>]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/KhronosGroup/Vulkan-Headers.git' | sed -n 's,.*refs/tags/v\([0-9][0-9.]*\)$,\1,p' | sort -Vr | head -1)
check noupdate

# vulkan-loader (check only, updated separately)
pkg=vulkan-loader
a=$(cat ./packages/vulkan-loader.cmake | grep 'Vulkan-Loader' | sed -n 's,.*v\([0-9][^>]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/KhronosGroup/Vulkan-Loader.git' | sed -n 's,.*refs/tags/v\([0-9][0-9.]*\)$,\1,p' | sort -Vr | head -1)
check noupdate

# zlib
pkg=zlib
a=$(cat ./packages/zlib.cmake | grep 'zlib-ng' | sed -n 's,.*/\([0-9][^>]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/zlib-ng/zlib-ng.git' | sed -n 's,.*refs/tags/\([0-9][0-9.]*\)$,\1,p' | sort -Vr | head -1)
check
update "tags/$a" "tags/$b"

# zstd
pkg=zstd
a=$(cat ./packages/zstd.cmake | grep 'zstd' | sed -n 's,.*zstd-\([0-9][^>]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/facebook/zstd.git' | sed -n 's,.*refs/tags/v\([0-9][0-9.]*\)$,\1,p' | sort -Vr | head -1)
check
update "$a" "$b"