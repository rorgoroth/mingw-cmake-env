ExternalProject_Add(ffmpeg
    DEPENDS
        amf-headers
        bzip2
        fribidi
        gmp
        libass
        libpng
        libvpx
        libwebp
        libxml2
        libzimg
        opus
        speex
        vorbis
        x264
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
        --enable-amf
        --enable-cross-compile
        --enable-gmp
        --enable-gpl
        --enable-version3
        --enable-libass
        --enable-libfreetype
        --enable-libfribidi
        --enable-libopus
        --enable-libspeex
        --enable-libvorbis
        --enable-libvpx
        --enable-libwebp
        --enable-libx264
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
