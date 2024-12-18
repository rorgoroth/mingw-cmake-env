ExternalProject_Add(
  fribidi
  GIT_REPOSITORY https://github.com/fribidi/fribidi.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} meson setup --reconfigure <BINARY_DIR> <SOURCE_DIR>
    ${meson_conf_args}
    -Dbin=false
    -Dcpp_args='-DFRIBIDI_LIB_STATIC'
    -Ddocs=false
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA} -C <BINARY_DIR> install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(fribidi)
force_meson_configure(fribidi)
