ExternalProject_Add(
  gcc
  DEPENDS gcc-base winpthreads gendef
  SOURCE_DIR gcc-prefix/src
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install-strip
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)
