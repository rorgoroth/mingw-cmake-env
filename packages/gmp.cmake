ExternalProject_Add(gmp
  URL https://gmplib.org/download/gmp/gmp-6.2.1.tar.xz
  URL_HASH MD5=0b82665c4a92fd2ade7440c13fcaa42b
  CONFIGURE_COMMAND ${EXEC} <SOURCE_DIR>/configure
    CC_FOR_BUILD=cc
    --host=${TARGET_ARCH}
    --prefix=${MINGW_INSTALL_PREFIX}
    --disable-shared
    --enable-static
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  LOG_DOWNLOAD 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

