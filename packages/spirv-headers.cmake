  ExternalProject_Add(
  spirv-headers
  GIT_REPOSITORY https://github.com/rorgoroth/mpv-shaderc.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} cmake -H<SOURCE_DIR>/third_party/spirv-headers/ -B<BINARY_DIR>
    ${cmake_conf_args}
  BUILD_COMMAND ""
  INSTALL_COMMAND ${NINJA} -C <BINARY_DIR> install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(spirv-headers)
