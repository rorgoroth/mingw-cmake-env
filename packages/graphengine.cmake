ExternalProject_Add(
  graphengine
  GIT_REPOSITORY https://github.com/sekrit-twc/graphengine.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
  BUILD_IN_SOURCE 1
  LOG_DOWNLOAD 1
  LOG_UPDATE 1)

force_rebuild_git(graphengine)
