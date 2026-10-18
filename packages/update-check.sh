#!/bin/sh
# Checks upstream for new releases of the packages listed below. When a newer
# version is found, the URL and URL_HASH in the package's .cmake file are
# rewritten in place (the new tarball is downloaded to work out the SHA256).
# Each updated package is then committed on its own, e.g.
#   packages/curl: 8.22.0 -> 8.23.0
# Only that package's .cmake file is committed, anything else that is staged or
# modified in the working tree is left alone.
#
# Usage (from the repository root):
#   sh ./packages/update-check.sh                check, update and commit
#   sh ./packages/update-check.sh --no-commit    check and update, don't commit
#   sh ./packages/update-check.sh -n             check only, don't touch any files
#
# vulkan-headers and vulkan-loader are checked but never updated or committed,
# they are handled separately.
#
# Output: one "pkg: old -> new" row per package, so it can be piped through
# "column -t". Everything else ([UPDATED], [FAILED ...], commit errors) is
# printed after the rows, separated by an empty line, so it can't disturb the
# columns. run.sh checkupdates formats the two parts separately.
# The exit status is 1 if a version lookup, download or commit failed.
export LC_NUMERIC="C"

UPDATE=1
COMMIT=1
for arg in "$@"; do
    case "$arg" in
        -n|--check-only) UPDATE=0 ;;
        --no-commit) COMMIT=0 ;;
        -h|--help) echo "Usage: $0 [-n|--check-only] [--no-commit]"; exit 0 ;;
        *) echo "Unknown option: $arg" >&2; exit 1 ;;
    esac
done

# Status messages are collected here and printed after the version rows.
STATUS_FILE=$(mktemp) || exit 1
trap 'rm -f "$STATUS_FILE"' EXIT
trap 'exit 1' INT TERM
FAILURES=0

# report <message>: add a status line for the current package
report() {
    printf '%s: %s\n' "$pkg" "$*" >> "$STATUS_FILE"
}

# fail <message>: like report, and make the exit status non-zero
fail() {
    FAILURES=$((FAILURES + 1))
    report "$*"
}

# check: print the version row for $pkg ($a is the current version, $b the
# latest upstream one) and set $new if upstream is newer. A missing version
# means the lookup broke (network error, upstream page changed), say so
# instead of pretending the package is up to date.
check() {
    new=0
    if [ -z "$a" ] || [ -z "$b" ]; then
        echo "$pkg: ${a:-?} -> ${b:-?} [LOOKUP FAILED]"
        FAILURES=$((FAILURES + 1))
        return 0
    fi
    if ! printf "%s\n%s\n" "$b" "$a" | sort -cV >/dev/null 2>&1; then
        new=1
        echo "$pkg: $a -> $b [NEW]"
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

# commit_update: commit packages/$pkg.cmake as "packages/$pkg: $a -> $b".
# Sets commit_status (text to append to the status line) and commit_err.
# $1 is "dirty" if the file already had uncommitted changes before the update,
# in which case nothing is committed so those changes don't end up in the
# commit.
commit_update() {
    commit_status=""
    commit_err=""
    [ "$COMMIT" = 1 ] || return 0
    git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return 0

    if [ "$1" = dirty ]; then
        commit_status=" [NOT COMMITTED: file had uncommitted changes]"
        return 0
    fi

    # "-- <file>" makes git commit only that file, whatever else is staged
    if commit_err=$(git add -- "$file" 2>&1 &&
                    git commit -q -m "packages/$pkg: $a -> $b" -- "$file" 2>&1); then
        commit_err=""
        commit_status=" [COMMITTED]"
    else
        commit_status=" [COMMIT FAILED]"
    fi
}

# update [-s <sed expr>] <old> <new> [<old> <new> ...]
# Applies the literal substitutions to the URL in packages/$pkg.cmake,
# downloads the new tarball and rewrites URL and URL_HASH in the file, then
# commits the change. -s runs an extra sed expression on the file before the
# commit, for packages that mention the version somewhere other than the URL.
# Does nothing unless check() flagged the package as [NEW]. The file is left
# untouched if anything goes wrong.
update() {
    sed_expr=
    if [ "$1" = -s ]; then
        sed_expr=$2
        shift 2
    fi
    if [ "$new" != 1 ] || [ "$UPDATE" != 1 ]; then
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
        fail "[FAILED: could not work out the new URL]"
        return 1
    fi

    # remember whether the file has uncommitted changes of its own
    dirty=clean
    git diff --quiet HEAD -- "$file" >/dev/null 2>&1 || dirty=dirty

    tmp=$(mktemp)
    if ! wget -q -O "$tmp" "$new_url" || [ ! -s "$tmp" ]; then
        rm -f "$tmp"
        fail "[FAILED: download failed] $new_url"
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
    [ -n "$sed_expr" ] && sed -i "$sed_expr" "$file"

    commit_update "$dirty"
    status=" [UPDATED]$commit_status"
    for p in ./packages/"$pkg"-*.patch; do
        [ -e "$p" ] && status="$status [CHECK PATCHES]" && break
    done
    if [ "$commit_status" = " [COMMIT FAILED]" ]; then
        fail "${status# }"
        [ -n "$commit_err" ] && report "$(printf '%s' "$commit_err" | tr '\n' ' ')"
    else
        report "${status# }"
    fi
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
# x.y.9z tags are development snapshots
b=$(git ls-remote --tags 'https://gitlab.freedesktop.org/fontconfig/fontconfig.git' | sed -n 's,.*refs/tags/\([0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\)$,\1,p' | awk -F. '$3 < 90' | sort -Vr | head -1)
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
b=$(git ls-remote --tags 'https://github.com/libsdl-org/SDL.git' | sed -n 's,.*refs/tags/release-\(2\.[0-9][0-9.]*\)$,\1,p' | sort -Vr | head -1)
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
b=$(git ls-remote --tags 'https://codeberg.org/ccxvii/mujs.git' | sed -n 's,.*refs/tags/\([0-9][0-9.]*\)$,\1,p' | sort -Vr | head -1)
check
update -s "s/VERSION=$a\"/VERSION=$b\"/" "/$a.tar" "/$b.tar"

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
check

# vulkan-loader (check only, updated separately)
pkg=vulkan-loader
a=$(cat ./packages/vulkan-loader.cmake | grep 'Vulkan-Loader' | sed -n 's,.*v\([0-9][^>]*\)\.tar.*,\1,p')
b=$(git ls-remote --tags 'https://github.com/KhronosGroup/Vulkan-Loader.git' | sed -n 's,.*refs/tags/v\([0-9][0-9.]*\)$,\1,p' | sort -Vr | head -1)
check

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

# status lines after the version rows
if [ -s "$STATUS_FILE" ]; then
    echo
    cat "$STATUS_FILE"
fi
[ "$FAILURES" -eq 0 ]
