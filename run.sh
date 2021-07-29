#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m'

pushd build >/dev/null 2>&1 || exit
    ninja update && ninja || exit
    echo -e "${GREEN}>> Deleting old binaries..${NC}"
    rm -v ../bin/*/*.{exe,com}
    echo -e "${GREEN}>> ..Done!${NC}" && echo
    echo -e "${GREEN}>> Copying new binaries..${NC}"
    cp -rv packages/*-package ../bin
    echo -e "${GREEN}>> ..Done!${NC}"
popd >/dev/null 2>&1 || exit
