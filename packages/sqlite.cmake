ExternalProject_Add(
  sqlite
  URL https://www.sqlite.org/2025/sqlite-autoconf-3500100.tar.gz
  URL_HASH SHA256=00a65114d697cfaa8fe0630281d76fd1b77afcd95cd5e40ec6a02cbbadbfea71
  DOWNLOAD_EXTRACT_TIMESTAMP 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} <SOURCE_DIR>/configure
    ${autotools_conf_args}
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  BUILD_IN_SOURCE 1
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

