ExternalProject_Add(ffmpeg
  DEPENDS
    bzip2
    gmp
    libass
    libpng
    libxml2
    libzimg
    spirv-cross
    vulkan-loader
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
    --disable-doc
    --disable-encoders
    --disable-filters
    --disable-htmlpages
    --disable-libfreetype
    --disable-libfribidi
    --disable-manpages
    --disable-muxers
    --disable-podpages
    --disable-programs
    --disable-txtpages
    --enable-cross-compile
    --enable-gmp
    --enable-gpl
    --enable-version3
    --enable-libass
    --enable-libxml2
    --enable-libzimg
    --enable-nonfree
    --enable-postproc
    --enable-runtime-cpudetect
    --enable-schannel
    --enable-vulkan
  BUILD_COMMAND ${EXEC} ${MAKE}
  INSTALL_COMMAND ${EXEC} ${MAKE} install
  LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(ffmpeg)
