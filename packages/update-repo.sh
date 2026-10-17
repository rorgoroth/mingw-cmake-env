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

    if ! old=$(git -C "$src_dir" rev-parse --verify --quiet '@{u}'); then
        echo "WARNING: $name: no upstream branch, skipped" >&2
        return 1
    fi

    # Fetch first and leave the checkout alone unless upstream really moved.
    # Resetting before knowing that would throw away the patches applied with
    # "git am" (spirv-cross, libvpl) while the stamps still claim they are
    # applied, and a failed fetch (network error, rate limit) would do the
    # same for nothing.
    if ! git -C "$src_dir" fetch --quiet >/dev/null 2>&1; then
        echo "WARNING: $name: fetch failed, keeping current checkout" >&2
        return 1
    fi

    if ! new=$(git -C "$src_dir" rev-parse --verify --quiet '@{u}'); then
        echo "WARNING: $name: upstream branch vanished, keeping current checkout" >&2
        return 1
    fi
    [[ "$old" == "$new" ]] && return 0

    git -C "$src_dir" am --abort >/dev/null 2>&1 || true
    if ! git -C "$src_dir" reset --hard "$new" >/dev/null 2>&1; then
        echo "WARNING: $name: could not reset to upstream, skipped" >&2
        return 1
    fi

    echo "Updating $name"
    rm -f "$stamp_dir/$name-patch" \
          "$stamp_dir/$name-force-git-patch" \
          "$stamp_dir/$name-configure" \
          "$stamp_dir/$name-build" \
          "$stamp_dir/$name-install" \
          "$stamp_dir/$name-done"
}

main
