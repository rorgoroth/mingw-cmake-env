ExternalProject_Add(
  libwebp
  URL https://github.com/webmproject/libwebp/archive/refs/tags/v1.2.4.tar.gz
  URL_HASH MD5=4f08244f88a39816c3e0719ca16c7a92
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
