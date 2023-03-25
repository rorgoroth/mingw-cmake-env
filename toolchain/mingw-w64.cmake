ExternalProject_Add(
  mingw-w64
  EXCLUDE_FROM_ALL 1
  PREFIX mingw-w64-prefix
  URL https://github.com/mirror/mingw-w64/archive/eff726c461e09f35eeaed125a3570fa5f807f02b.tar.gz
  URL_HASH MD5=dab2c7588481190dd1a6a821cded66be
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)
