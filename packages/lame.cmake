ExternalProject_Add(
  lame
  GIT_REPOSITORY https://gitlab.com/shinchiro/lame.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} autoupdate -f && <SOURCE_DIR>/configure
    ${autotools_conf_args}
    --disable-frontend
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  BUILD_IN_SOURCE 1
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(lame)
