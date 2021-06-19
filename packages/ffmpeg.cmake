ExternalProject_Add(ffmpeg
    DEPENDS
        bzip2
        fribidi
        gmp
        libass
        libpng
        libxml2
        libzimg
        xvidcore
    GIT_REPOSITORY https://github.com/FFmpeg/FFmpeg.git
    GIT_SHALLOW 1
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} dash <SOURCE_DIR>/configure
        --cross-prefix=${TARGET_ARCH}-
        --prefix=${MINGW_INSTALL_PREFIX}
        --arch=${TARGET_CPU}
        --target-os=mingw32
        --target-exec=wine
        --pkg-config-flags=--static
        --enable-cross-compile
        --enable-gmp
        --enable-gpl
        --enable-version3
        --enable-libass
        --enable-libfreetype
        --enable-libfribidi
        --enable-libxml2
        --enable-libxvid
        --enable-libzimg
        --enable-nonfree
        --enable-postproc
        --enable-runtime-cpudetect
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(ffmpeg)
extra_step(ffmpeg)
