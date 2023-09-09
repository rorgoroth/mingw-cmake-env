set(flag
"CFLAGS='-UHAVE_READLINE' LIBREADLINE=''
CC=x86_64-w64-mingw32-clang
AR=x86_64-w64-mingw32-llvm-ar
RANLIB=x86_64-w64-mingw32-llvm-ranlib
OUT=<BINARY_DIR>
prefix=${MINGW_INSTALL_PREFIX}
host=mingw
VERSION=1.3.3")

ExternalProject_Add(
  mujs
  URL https://github.com/ccxvii/mujs/archive/refs/tags/1.3.3.tar.gz
  URL_HASH MD5=ba876c5c3bff4ef988b405a148ec111e
  PATCH_COMMAND ${EXEC} patch -p1 < ${CMAKE_CURRENT_SOURCE_DIR}/mujs-0001.patch
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ${MAKE} -C <SOURCE_DIR> ${flag}
  INSTALL_COMMAND ${MAKE} -C <SOURCE_DIR> ${flag} install
  BUILD_IN_SOURCE 1
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)
