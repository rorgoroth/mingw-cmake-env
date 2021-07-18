#!/bin/bash

pushd build
    ninja update
    ninja -j1
    cp -r packages/mpv-package ../bin/
    cp -r packages/quake3e-package ../bin/
    cp -r packages/quake3e-urt-package ../bin/
popd
