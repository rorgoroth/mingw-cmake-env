ExternalProject_Add(ffmpeg
    DEPENDS
        amf-headers
        bzip2
        gmp
        lame
        libressl
        libass
        libpng
        libvpx
        libwebp
        libzimg
        opus
        speex
        vorbis
        x264
        xvidcore
        libxml2
    GIT_REPOSITORY https://github.com/FFmpeg/FFmpeg.git
    GIT_SHALLOW 1
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} <SOURCE_DIR>/configure
        --cross-prefix=${TARGET_ARCH}-
        --prefix=${MINGW_INSTALL_PREFIX}
        --arch=${TARGET_CPU}
        --target-os=mingw32
        --target-exec=wine
        --pkg-config-flags=--static
        --enable-cross-compile
        --enable-runtime-cpudetect
        --enable-gpl
        --enable-version3
        --enable-nonfree
        --enable-amf
        --enable-postproc
        --enable-gmp
        --enable-libass
        --enable-libfreetype
        --enable-libfribidi
        --enable-libmp3lame
        --enable-libopus
        --enable-libspeex
        --enable-libvorbis
        --enable-libvpx
        --enable-libwebp
        --enable-libx264
        --enable-libxvid
        --enable-libzimg
        --enable-libtls
        --enable-libxml2
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(ffmpeg)
extra_step(ffmpeg)
