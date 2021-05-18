#!/bin/bash

pushd build
    ninja update
    ninja mpv
    cp -v packages/mpv-prefix/src/mpv/build/mpv.exe ../
    cp -v packages/mpv-prefix/src/mpv/build/mpv.com ../
popd
