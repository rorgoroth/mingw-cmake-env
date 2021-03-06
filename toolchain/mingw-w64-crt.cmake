ExternalProject_Add(
  mingw-w64-crt
  DEPENDS mingw-w64 gcc-base
  PREFIX mingw-w64-prefix
  SOURCE_DIR mingw-w64-prefix/src
  CONFIGURE_COMMAND
    ${EXEC} <SOURCE_DIR>/mingw-w64/mingw-w64-crt/configure
    --host=${TARGET_ARCH}
    --prefix=${MINGW_INSTALL_PREFIX}
    --with-sysroot=${CMAKE_INSTALL_PREFIX}
    --with-default-msvcrt=msvcrt-os
    --disable-lib32
    --enable-lib64
    --enable-wildcard
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install-strip
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)
