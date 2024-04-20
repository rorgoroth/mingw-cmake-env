ExternalProject_Add(
    libsamplerate
  GIT_REPOSITORY https://github.com/libsndfile/libsamplerate.git
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR>
    ${cmake_conf_args}
    -DBUILD_TESTING=OFF
    -DLIBSAMPLERATE_EXAMPLES=OFF
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA} -C <BINARY_DIR> install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(libsamplerate)
