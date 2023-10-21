ExternalProject_Add(
  libunibreak
  GIT_REPOSITORY https://github.com/adah1972/libunibreak.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} <SOURCE_DIR>/configure
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

force_rebuild_git(libunibreak)
