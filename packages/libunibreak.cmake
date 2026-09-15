ExternalProject_Add(
  libunibreak
  URL https://github.com/adah1972/libunibreak/archive/refs/tags/libunibreak_8_0.tar.gz
  URL_HASH SHA256=35f1008184c13de55793fa292b62a0c10739f1294f401a3b6a772edc145a4b3b
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

