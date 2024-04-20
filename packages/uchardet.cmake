ExternalProject_Add(
  uchardet
  GIT_REPOSITORY https://gitlab.freedesktop.org/uchardet/uchardet.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR>
    ${cmake_conf_args}
    -DTARGET_ARCHITECTURE=x86_64
    -DBUILD_BINARY=OFF
    -DBUILD_STATIC=ON
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA} -C <BINARY_DIR> install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(uchardet)
