ExternalProject_Add(fdk-aac
  GIT_REPOSITORY https://github.com/mstorsjo/fdk-aac.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR>
    ${cmake_conf_args}
    -DBUILD_PROGRAMS=OFF
    -DFDK_AAC_INSTALL_CMAKE_CONFIG_MODULE=ON
    -DFDK_AAC_INSTALL_PKGCONFIG_MODULE=ON
    BUILD_COMMAND ${NINJA}
    INSTALL_COMMAND ${NINJA} install
    LOG_DOWNLOAD 1
    LOG_UPDATE 1
    LOG_CONFIGURE 1
    LOG_BUILD 1
    LOG_INSTALL 1)

force_rebuild_git(fdk-aac)
