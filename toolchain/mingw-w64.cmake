ExternalProject_Add(
  mingw-w64
  EXCLUDE_FROM_ALL 1
  PREFIX mingw-w64-prefix
  URL https://github.com/mingw-w64/mingw-w64/archive/e3f561cffc41110a1946c682256a17d42ceecf1d.tar.gz
  URL_HASH MD5=15579cd24dc98fa900e6a2bb11567fb3
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)
