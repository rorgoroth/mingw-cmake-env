ExternalProject_Add(
  libvpx
  URL https://github.com/webmproject/libvpx/archive/refs/tags/v1.12.0.tar.gz
  URL_HASH MD5=10cf85debdd07be719a35ca3bfb8ea64
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} CROSS=${TARGET_ARCH}- <SOURCE_DIR>/configure
    --extra-cflags='-fno-asynchronous-unwind-tables'
    --target=x86_64-win64-gcc
    --prefix=${MINGW_INSTALL_PREFIX}
    --as=yasm
    --disable-decode-perf-tests
    --disable-docs
    --disable-encode-perf-tests
    --disable-examples
    --disable-tools
    --disable-unit-tests
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
          COMMAND ${EXEC} ${TARGET_ARCH}-ranlib
          ${MINGW_INSTALL_PREFIX}/lib/libvpx.a
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)
