ExternalProject_Add(
  mingw-w64
  EXCLUDE_FROM_ALL 1
  PREFIX mingw-w64-prefix
  URL https://github.com/mirror/mingw-w64/archive/a57cacad31f5766d45959b6c0f9b122918d545fa.tar.gz
  URL_HASH MD5=f50d6c5dfe03febfba49413425b1bcc5
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)
