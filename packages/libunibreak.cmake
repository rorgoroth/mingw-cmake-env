ExternalProject_Add(
  libunibreak
  URL https://github.com/adah1972/libunibreak/archive/refs/tags/libunibreak_7_0.tar.gz
  URL_HASH MD5=b60346b804d6ad38900d9c2576488c72
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} autoreconf -fi && <SOURCE_DIR>/configure
    ${autotools_conf_args}
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  BUILD_IN_SOURCE 1
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

