ExternalProject_Add(
  sqlite
  URL https://www.sqlite.org/2024/sqlite-autoconf-3450300.tar.gz
  URL_HASH MD5=f418272ba1d588747dcd4201018ed912
  DOWNLOAD_EXTRACT_TIMESTAMP 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} autoreconf -fi && <SOURCE_DIR>/configure
    ${autotools_conf_args}
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  BUILD_IN_SOURCE 1
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

