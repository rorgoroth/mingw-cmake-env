ExternalProject_Add(
  widl
  EXCLUDE_FROM_ALL 1
  DEPENDS mingw-w64
  PREFIX mingw-w64-prefix
  SOURCE_DIR mingw-w64-prefix/src
  CONFIGURE_COMMAND
    ${EXEC} <SOURCE_DIR>/mingw-w64/mingw-w64-tools/widl/configure
    --prefix=${CMAKE_INSTALL_PREFIX}
    --target=${TARGET_ARCH}
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install-strip
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)
