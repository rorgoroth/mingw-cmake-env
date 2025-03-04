ExternalProject_Add(
  x264
  GIT_REPOSITORY https://github.com/zhongflyTeam/x264.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} <SOURCE_DIR>/configure
    ${autotools_conf_args}
    --cross-prefix=x86_64-w64-mingw32-
    --disable-cli
    --disable-ffms
    --disable-gpac
    --disable-lavf
    --disable-lsmash
    --disable-swscale
    --enable-lto
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(x264)
