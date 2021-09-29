#!/bin/sh

cd build || exit
    ninja update && ninja || exit
    rm ../bin/*/*.exe
    rm ../bin/*/*.com
    rm ../bin/*/*.dll
    cp -rv packages/*-package ../bin
cd .. || exit
