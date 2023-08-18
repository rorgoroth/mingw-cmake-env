ExternalProject_Add(
  libvpx
  GIT_REPOSITORY https://chromium.googlesource.com/webm/libvpx.git
  GIT_SHALLOW 1
  GIT_REMOTE_NAME origin
  GIT_TAG main
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} CROSS=x86_64-w64-mingw32- <SOURCE_DIR>/configure
    --extra-cflags='-fno-asynchronous-unwind-tables'
    --target=x86_64-win64-gcc
    --prefix=${MINGW_INSTALL_PREFIX}
    --as=yasm
    --disable-decode-perf-tests
    --disable-encode-perf-tests
    --disable-docs
    --disable-examples
    --disable-shared
    --disable-tools
    --disable-unit-tests
    --enable-postproc
    --enable-runtime-cpu-detect
    --enable-static
    --enable-vp8
    --enable-vp9
    --enable-vp9-postproc
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
          COMMAND ${EXEC} x86_64-w64-mingw32-ranlib
          ${MINGW_INSTALL_PREFIX}/lib/libvpx.a
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(libvpx)
