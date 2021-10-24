ExternalProject_Add(libiconv
  URL https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.16.tar.gz
  URL_HASH MD5=7d2a800b952942bb2880efb00cfd524c
  CONFIGURE_COMMAND ${EXEC} <SOURCE_DIR>/configure
    --host=${TARGET_ARCH}
    --prefix=${MINGW_INSTALL_PREFIX}
    --disable-nls
    --disable-shared
    --enable-extra-encodings
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

extra_step(libiconv)
