#!/bin/bash

# Max number of repositories updated at the same time.
MAX_JOBS=${MAX_JOBS:-8}

main() {
    packages_dir=$(pwd)
    for dir in "$packages_dir"/*-prefix; do
        [[ -d "$dir" ]] || continue
        local name=${dir##*/}
        name=${name%-prefix}
        local src_dir=$packages_dir/$name-prefix/src/$name
        local stamp_dir=$packages_dir/$name-prefix/src/$name-stamp

        if [[ -d "$src_dir/.git" ]]; then
            while (( $(jobs -rp | wc -l) >= MAX_JOBS )); do
                wait -n
            done
            gitupdate "$name" "$src_dir" "$stamp_dir" &
        fi
    done
    wait
}

gitupdate() {
    local name=$1
    local src_dir=$2
    local stamp_dir=$3
    local old new

    git -C "$src_dir" am --abort >/dev/null 2>&1 || true
    if ! git -C "$src_dir" reset --hard "@{u}" >/dev/null 2>&1; then
        echo "WARNING: $name: could not reset to upstream, skipped" >&2
        return 1
    fi

    old=$(git -C "$src_dir" rev-parse HEAD)

    # A failed pull (network error, rate limit, rewritten history) must not be
    # mistaken for "up to date" nor trigger a rebuild.
    if ! git -C "$src_dir" pull --ff-only --quiet >/dev/null 2>&1; then
        echo "WARNING: $name: pull failed, keeping current checkout" >&2
        return 1
    fi

    new=$(git -C "$src_dir" rev-parse HEAD)
    [[ "$old" == "$new" ]] && return 0

    echo "Updating $name"
    rm -f "$stamp_dir/$name-patch" \
          "$stamp_dir/$name-force-git-patch" \
          "$stamp_dir/$name-configure" \
          "$stamp_dir/$name-build" \
          "$stamp_dir/$name-install" \
          "$stamp_dir/$name-done"
}

main
