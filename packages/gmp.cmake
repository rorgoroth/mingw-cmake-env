ExternalProject_Add(
  gmp
  URL https://www.mirrorservice.org/pub/gnu/gmp/gmp-6.3.0.tar.zst
  URL_HASH MD5=645d25907d6ff7d7b9c5ad7b998b170a
  DOWNLOAD_EXTRACT_TIMESTAMP 1
  CONFIGURE_COMMAND
    ${EXEC} <SOURCE_DIR>/configure CC_FOR_BUILD=cc
    ${autotools_conf_args}
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

