ExternalProject_Add(
  fast-float
  GIT_REPOSITORY https://github.com/fastfloat/fast_float.git
  GIT_SHALLOW 1
  GIT_REMOTE_NAME origin
  GIT_TAG main
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
  LOG_DOWNLOAD 1
  LOG_UPDATE 1)

force_rebuild_git(fast-float)
