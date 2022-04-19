ExternalProject_Add(mingw-w64
  PREFIX mingw-w64-prefix
  URL https://github.com/mirror/mingw-w64/archive/refs/tags/v10.0.0.tar.gz
  URL_HASH MD5=8e4bd21fd2349ddb95d2551ff2950a4e
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
  LOG_DOWNLOAD 1 LOG_UPDATE 1
)
