ExternalProject_Add(
  libunibreak
  URL https://github.com/adah1972/libunibreak/releases/download/libunibreak_6_0/libunibreak-6.0.tar.gz
  URL_HASH MD5=00bbb0cfb0dc7011d58452440f28d948
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} <SOURCE_DIR>/configure
    --host=x86_64-w64-mingw32
    --prefix=${MINGW_INSTALL_PREFIX}
    --disable-shared
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  BUILD_IN_SOURCE 1
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

