ExternalProject_Add(mingw-w64
  PREFIX mingw-w64-prefix
  URL https://github.com/mirror/mingw-w64/archive/refs/tags/v9.0.0.tar.gz
  URL_HASH MD5=48a350a4679cb329405b00137dee9809
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
  LOG_DOWNLOAD 1 LOG_UPDATE 1
)
