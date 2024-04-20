ExternalProject_Add(
  libjpeg
  GIT_REPOSITORY https://github.com/libjpeg-turbo/libjpeg-turbo.git
  GIT_REMOTE_NAME origin
  GIT_TAG main
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC-NLTO} cmake -H<SOURCE_DIR> -B<BINARY_DIR>
    ${cmake_conf_args}
    -DENABLE_SHARED=OFF
    -DENABLE_STATIC=ON
    -DWITH_TURBOJPEG=OFF
  BUILD_COMMAND ${NINJA-NLTO} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA-NLTO} -C <BINARY_DIR> install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(libjpeg)
