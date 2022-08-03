ExternalProject_Add(
  libwebp
  URL https://github.com/webmproject/libwebp/archive/refs/tags/v1.2.3.tar.gz
  URL_HASH MD5=a9d3c93923ab0e5eab649a965b7b2bcd
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} <SOURCE_DIR>/configure
    --host=${TARGET_ARCH}
    --prefix=${MINGW_INSTALL_PREFIX}
    --disable-shared
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

autogen(libwebp)
