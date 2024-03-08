ExternalProject_Add(
  winpthreads
  EXCLUDE_FROM_ALL 1
  DEPENDS mingw-w64-crt
  PREFIX mingw-w64-prefix
  SOURCE_DIR mingw-w64-prefix/src
  CONFIGURE_COMMAND
    ${EXEC} <SOURCE_DIR>/mingw-w64/mingw-w64-libraries/winpthreads/configure
    --host=${TARGET_ARCH}
    --prefix=${MINGW_INSTALL_PREFIX}
    --disable-shared
    --enable-static CFLAGS='-DWINPTHREAD_STATIC'
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install-strip
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)
