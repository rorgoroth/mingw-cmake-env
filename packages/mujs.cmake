set(flags
"prefix=${MINGW_INSTALL_PREFIX}
OUT=<BINARY_DIR>
host=mingw
HAVE_READLINE=no
VERSION=1.3.7")

ExternalProject_Add(
  mujs
  URL https://codeberg.org/ccxvii/mujs/archive/1.3.7.tar.gz
  URL_HASH MD5=2e7968238107efa465e8c870049d7bfa
  DOWNLOAD_EXTRACT_TIMESTAMP 1
  PATCH_COMMAND ${EXEC} patch -p1 < ${CMAKE_CURRENT_SOURCE_DIR}/mujs-0001.patch
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ${MAKE} ${flags}
  INSTALL_COMMAND ${MAKE} ${flags} install-static
  BUILD_IN_SOURCE 1
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

