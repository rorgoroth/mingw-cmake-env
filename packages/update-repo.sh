#!/bin/bash

main() {
    packages_dir=$(pwd)
    for dir in "$packages_dir"/*-prefix; do
        local name=$(echo $(basename "$dir") | sed -e 's|-prefix$||')
        local src_dir=$packages_dir/$name-prefix/src/$name
        local stamp_dir=$packages_dir/$name-prefix/src/$name-stamp

        if [[ -d "$src_dir/.git" ]]; then
            gitupdate "$name" "$src_dir" "$stamp_dir" &
        fi
    done
    wait
}

gitupdate() {
    local name=$1
    local src_dir=$2
    local stamp_dir=$3

    git -C "$src_dir" am --abort >/dev/null 2>&1 || true
    git -C "$src_dir" reset --hard "@{u}" >/dev/null

    result=$(git -C "$src_dir" pull 2>&1)

    if [[ ! "$result" =~ up[-\ ]to[-\ ]date ]]; then
        echo "Updating $name"
        rm -f "$stamp_dir/$name-patch" \
              "$stamp_dir/$name-force-git-patch" \
              "$stamp_dir/$name-configure" \
              "$stamp_dir/$name-build" \
              "$stamp_dir/$name-install" \
              "$stamp_dir/$name-done"
    fi
}

main
