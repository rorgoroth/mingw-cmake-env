ExternalProject_Add(
  lame
  GIT_REPOSITORY https://gitlab.com/shinchiro/lame.git
  GIT_SHALLOW 1
  PATCH_COMMAND ${EXEC} git am -3 ${CMAKE_CURRENT_SOURCE_DIR}/lame-*.patch
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} autoupdate -f && autoreconf -fi && <SOURCE_DIR>/configure
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
