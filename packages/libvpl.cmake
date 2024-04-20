ExternalProject_Add(
  libvpl
  GIT_REPOSITORY https://github.com/intel/libvpl.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR>
    ${cmake_conf_args}
    -DBUILD_DEV=ON
    -DBUILD_DEV_ONLY=OFF
    -DBUILD_DISPATCHER=ON
    -DBUILD_DISPATCHER_ONEVPL_EXPERIMENTAL=ON
    -DBUILD_DISPATCHER_ONLY=OFF
    -DBUILD_EXAMPLES=OFF
    -DBUILD_PREVIEW=ON
    -DBUILD_TESTS=OFF
    -DBUILD_TOOLS=OFF
    -DBUILD_TOOLS_ONEVPL_EXPERIMENTAL=OFF
    -DINSTALL_EXAMPLE_CODE=OFF
    -DUSE_MSVC_STATIC_RUNTIME=OFF
    -DUSE_ONEAPI_INSTALL_LAYOUT=OFF
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA} -C <BINARY_DIR> install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(libvpl)
