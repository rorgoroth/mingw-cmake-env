ExternalProject_Add(
  libiconv
  URL https://cdimage.debian.org/mirror/gnu.org/gnu/libiconv/libiconv-1.19.1.tar.gz
  URL_HASH SHA256=9a06844846d664d7122161700c10a64480d7c7bcead3091925a785b38c91edab
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

