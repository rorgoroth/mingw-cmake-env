ExternalProject_Add(
  libiconv
  URL https://www.mirrorservice.org/sites/ftp.gnu.org/gnu/libiconv/libiconv-1.18.tar.gz
  URL_HASH MD5=1af69958b42981d3c3029ffb4c7ebaed
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

