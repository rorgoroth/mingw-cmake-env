ExternalProject_Add(
  sqlite
  DEPENDS gcc
  URL https://www.sqlite.org/2022/sqlite-autoconf-3390300.tar.gz
  URL_HASH MD5=b77730d5c2f8c85b223d1959d08b6514
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
