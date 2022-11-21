ExternalProject_Add(
  sqlite
  URL https://www.sqlite.org/2022/sqlite-autoconf-3400000.tar.gz
  URL_HASH MD5=c833d61da768a116fa16d910f43cfd9a
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} <SOURCE_DIR>/configure
    --host=${TARGET_ARCH}
    --prefix=${MINGW_INSTALL_PREFIX}
    --disable-shared
    --enable-static
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

autoreconf(sqlite)
