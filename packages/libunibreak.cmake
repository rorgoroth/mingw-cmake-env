ExternalProject_Add(
  libunibreak
  URL https://github.com/adah1972/libunibreak/archive/refs/tags/libunibreak_8_0_1.tar.gz
  URL_HASH SHA256=96e9074daf1f45ae9ddf461b5a9801991a6fe8b2025ea786486e0e023c34a2c5
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

