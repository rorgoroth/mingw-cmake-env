ExternalProject_Add(
  glad
  GIT_REPOSITORY https://github.com/Dav1dde/glad.git
  GIT_SHALLOW 1
  GIT_REMOTE_NAME origin
  GIT_TAG glad2
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(glad)
