#!/bin/bash

pushd build >/dev/null 2>&1 || exit
    ninja update && ninja || exit
    echo ">> Deleting old binaries.."
    rm ../bin/*/*.{exe,com}
    echo ">> ..Done"
    echo ">> Copying new binaries.."
    cp -r packages/*-package ../bin
    echo ">> ..Done"
popd >/dev/null 2>&1 || exit
