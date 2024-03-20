# luajit ships with a broken pkg-config file
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/luajit.pc.in
               ${CMAKE_CURRENT_BINARY_DIR}/luajit.pc @ONLY)

set(EXPORT
    "CROSS=x86_64-w64-mingw32-
    TARGET_SYS=Windows
    BUILDMODE=static
    FILE_T=luajit.exe
    CFLAGS='-D_WIN32_WINNT=0x0A00 -DUNICODE'
    XCFLAGS='-DLUAJIT_ENABLE_LUA52COMPAT'
    PREFIX=${MINGW_INSTALL_PREFIX}
    LDFLAGS='-flto=thin -Wl,--gc-sections'
    Q=")

ExternalProject_Add(
  luajit
  DEPENDS libiconv
  GIT_REPOSITORY https://github.com/openresty/luajit2.git
  GIT_REMOTE_NAME origin
  GIT_TAG v2.1-agentzh
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ${MAKE} -C <SOURCE_DIR>/src ${EXPORT} amalg
  INSTALL_COMMAND ${MAKE} ${EXPORT} install
  BUILD_IN_SOURCE 1
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

ExternalProject_Add_Step(
  luajit install-pc
  DEPENDEES install
  COMMAND
    ${CMAKE_COMMAND} -E copy
    ${CMAKE_CURRENT_BINARY_DIR}/luajit.pc
    ${MINGW_INSTALL_PREFIX}/lib/pkgconfig/luajit.pc)

force_rebuild_git(luajit)
clean_build(luajit install)
