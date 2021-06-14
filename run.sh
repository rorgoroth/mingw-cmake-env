#!/bin/bash

pushd build
    ninja update
    ninja -j1 mpv
    cp -rv packages/mpv-package ../
popd
