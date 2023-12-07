ExternalProject_Add(
  gmp
  URL https://www.mirrorservice.org/pub/gnu/gmp/gmp-6.3.0.tar.xz
  URL_HASH MD5=956dc04e864001a9c22429f761f2c283
  DOWNLOAD_EXTRACT_TIMESTAMP 1
  CONFIGURE_COMMAND
    ${EXEC} <SOURCE_DIR>/configure CC_FOR_BUILD=cc
    --host=x86_64-w64-mingw32
    --prefix=${MINGW_INSTALL_PREFIX}
    --disable-shared
    --enable-static
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)
