ExternalProject_Add(
  libuv
  URL https://github.com/libuv/libuv/archive/v1.44.2.tar.gz
  URL_HASH MD5=ce2e634d6af6e545dd02f5f19ea1465f
  CONFIGURE_COMMAND
    ${EXEC} <SOURCE_DIR>/configure
    --host=${TARGET_ARCH}
    --prefix=${MINGW_INSTALL_PREFIX}
    --enable-static
    --disable-shared
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

autogen(libuv)
