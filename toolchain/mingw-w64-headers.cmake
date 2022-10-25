ExternalProject_Add(
  mingw-w64-headers
  EXCLUDE_FROM_ALL 1
  DEPENDS binutils mingw-w64 widl
  PREFIX mingw-w64-prefix
  SOURCE_DIR mingw-w64-prefix/src
  CONFIGURE_COMMAND
    <SOURCE_DIR>/mingw-w64/mingw-w64-headers/configure
    --host=${TARGET_ARCH}
    --prefix=${MINGW_INSTALL_PREFIX}
    --enable-idl
    --enable-sdk=all
    --with-default-msvcrt=msvcrt
    --with-default-win32-winnt=0x0A00
  BUILD_COMMAND ""
  INSTALL_COMMAND make install-strip
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)
