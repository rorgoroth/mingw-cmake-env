ExternalProject_Add(
  rubberband
  URL https://github.com/breakfastquay/rubberband/archive/refs/tags/v3.2.0.tar.gz
  URL_HASH MD5=714f79bec124b4b31e439daff3312994
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} meson setup <BINARY_DIR> <SOURCE_DIR>
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
