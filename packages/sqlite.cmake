ExternalProject_Add(
  sqlite
  URL https://www.sqlite.org/2024/sqlite-autoconf-3450200.tar.gz
  URL_HASH MD5=27436d5446f3e2afa6bc2e82f9c4f6ba
  DOWNLOAD_EXTRACT_TIMESTAMP 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} autoreconf -fi && <SOURCE_DIR>/configure
    --host=x86_64-w64-mingw32
    --prefix=${MINGW_INSTALL_PREFIX}
    --disable-shared
    --enable-static
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  BUILD_IN_SOURCE 1
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

clean_build(sqlite install)
