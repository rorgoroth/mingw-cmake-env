ExternalProject_Add(
  libiconv
  URL https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.19.tar.gz
  URL_HASH MD5=c04d0fa4cae4e9a4febc457fc00ee519
  DOWNLOAD_EXTRACT_TIMESTAMP 1
  CONFIGURE_COMMAND
    ${EXEC} <SOURCE_DIR>/configure
    ${autotools_conf_args}
    --disable-nls
    --enable-extra-encodings
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

