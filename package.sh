#!/bin/sh

cd bin || exit

cd mpv-package || exit
7za a "mpv-$(date +"%Y-%m-%d").7z" -- ./*
cd .. || exit

cd quake3e-package || exit
7za a "quake3e-package-$(date +"%Y-%m-%d").7z" -- ./*
cd .. || exit

cd quake3e-urt-package || exit
7za a "quake3e-urt-package-$(date +"%Y-%m-%d").7z" -- ./*
cd .. || exit

mv -- */*.7z .

cd .. || exit
