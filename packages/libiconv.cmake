ExternalProject_Add(
  libiconv
  URL https://www.mirrorservice.org/sites/ftp.gnu.org/gnu/libiconv/libiconv-1.17.tar.gz
  URL_HASH MD5=d718cd5a59438be666d1575855be72c3
  DOWNLOAD_EXTRACT_TIMESTAMP 1
  CONFIGURE_COMMAND
    ${EXEC} <SOURCE_DIR>/configure
    --host=x86_64-w64-mingw32
    --prefix=${MINGW_INSTALL_PREFIX}
    --disable-nls
    --disable-shared
    --enable-extra-encodings
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

clean_build(libiconv install)
