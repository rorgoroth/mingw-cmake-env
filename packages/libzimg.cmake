ExternalProject_Add(
  libzimg
  URL https://github.com/sekrit-twc/zimg/archive/refs/tags/release-3.0.5.tar.gz
  URL_HASH MD5=af2c08cc0e695f4c0c225feed14e9f20
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} <SOURCE_DIR>/autogen.sh && <SOURCE_DIR>/configure
    --host=x86_64-w64-mingw32
    --prefix=${MINGW_INSTALL_PREFIX}
    --disable-shared
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  BUILD_IN_SOURCE 1
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)
