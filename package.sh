#!/bin/sh

cd bin || exit
rm -rf ./*.7z

cd mpv-package || exit
7za a "mpv-$(date +"%Y-%m-%d").7z" -- ./*
cd .. || exit

cd quake3e-package || exit
7za a "quake3e-$(date +"%Y-%m-%d").7z" -- ./*
cd .. || exit

cd quake3e-urt-package || exit
7za a "quake3e-urt-$(date +"%Y-%m-%d").7z" -- ./*
cd .. || exit

mv -- */*.7z .

cd .. || exit
