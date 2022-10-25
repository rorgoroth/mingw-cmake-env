ExternalProject_Add(
  gcc
  EXCLUDE_FROM_ALL 1
  DEPENDS gcc-base gendef winpthreads
  SOURCE_DIR gcc-prefix/src
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install-strip
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)
