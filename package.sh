#!/bin/sh

cd bin || exit
7za a "mpv-$(date +"%Y-%m-%d").7z" mpv-package/*
7za a "quake3e-package-$(date +"%Y-%m-%d").7z" quake3e-package/*
7za a "quake3e-urt-package-$(date +"%Y-%m-%d").7z" quake3e-urt-package/*
cd .. || exit
