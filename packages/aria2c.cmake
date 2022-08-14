ExternalProject_Add(
  aria2c
  DEPENDS c-ares
          expat
          gmp
          libiconv
          libuv
          sqlite
          zlib
  GIT_REPOSITORY https://github.com/aria2/aria2.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  PATCH_COMMAND ${EXEC} patch -p1 < ${CMAKE_CURRENT_SOURCE_DIR}/aria2c-0001.patch
  CONFIGURE_COMMAND
    ${EXEC} <SOURCE_DIR>/configure
    --host=${TARGET_ARCH}
    --prefix=${MINGW_INSTALL_PREFIX}
    --disable-shared
    --enable-static
    --with-libcares
    --with-libexpat
    --with-libgmp
    --with-libiconv
    --with-libuv
    --with-libz
    --with-sqlite3
    --with-wintls
    --without-libxml2
    ARIA2_STATIC=yes
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

ExternalProject_Add_Step(
  aria2c strip-binary
  DEPENDEES build
  COMMAND
    ${EXEC} ${TARGET_ARCH}-strip -s
    <BINARY_DIR>/src/aria2c.exe)

ExternalProject_Add_Step(
  aria2c copy-binary
  DEPENDEES strip-binary
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <BINARY_DIR>/src/aria2c.exe
    ${CMAKE_CURRENT_BINARY_DIR}/aria2c-package/aria2c.exe)


force_rebuild_git(aria2c)
autoreconf(aria2c)
