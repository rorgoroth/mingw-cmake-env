ExternalProject_Add(
  libvpx
  GIT_REPOSITORY https://chromium.googlesource.com/webm/libvpx.git
  GIT_SHALLOW 1
  GIT_REMOTE_NAME origin
  GIT_TAG main
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
  ${EXEC} CROSS=x86_64-w64-mingw32- <SOURCE_DIR>/configure
    --prefix=${MINGW_INSTALL_PREFIX}
    --disable-shared
    --enable-static
    --target=x86_64-win64-gcc
    --as=yasm
    --disable-decode-perf-tests
    --disable-encode-perf-tests
    --disable-docs
    --disable-examples
    --disable-tools
    --disable-unit-tests
    --enable-debug
    --enable-postproc
    --enable-runtime-cpu-detect
    --enable-vp8
    --enable-vp9
    --enable-vp9-postproc
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(libvpx)
