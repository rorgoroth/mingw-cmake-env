#!/bin/bash

pushd build
    ninja update
    ninja mpv
    cp -rv packages/mpv-package ../
popd
