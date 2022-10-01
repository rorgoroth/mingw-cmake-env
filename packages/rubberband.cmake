ExternalProject_Add(
  rubberband
  URL https://github.com/breakfastquay/rubberband/archive/refs/tags/v3.1.0.tar.gz
  URL_HASH MD5=3e56fdf4fec0f95b961df9fb2904a214
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} meson <BINARY_DIR> <SOURCE_DIR>
    --prefix=${MINGW_INSTALL_PREFIX}
    --libdir=${MINGW_INSTALL_PREFIX}/lib
    --cross-file=${MESON_CROSS}
    --buildtype=release
    --default-library=static
    -Dfft=builtin
    -Dresampler=builtin
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA} -C <BINARY_DIR> install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)
