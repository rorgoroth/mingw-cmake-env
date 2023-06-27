ExternalProject_Add(
  mingw-w64
  EXCLUDE_FROM_ALL 1
  PREFIX mingw-w64-prefix
  URL https://github.com/mingw-w64/mingw-w64/archive/c7c93e36a52fba279a18f508e7cb9a9b0b783e7e.tar.gz
  URL_HASH MD5=e7cfeb816233893d3bcdb26e140e9f83
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)
