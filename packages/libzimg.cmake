ExternalProject_Add(libzimg
  URL https://github.com/sekrit-twc/zimg/archive/refs/tags/release-3.0.4.tar.gz
  URL_HASH MD5=9ef18426caecf049d3078732411a9802
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND ${EXEC} <SOURCE_DIR>/configure
    --host=${TARGET_ARCH}
    --prefix=${MINGW_INSTALL_PREFIX}
    --disable-shared
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  LOG_DOWNLOAD 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

autogen(libzimg)
