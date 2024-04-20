ExternalProject_Add(
  spirv-cross
  GIT_REPOSITORY https://github.com/KhronosGroup/SPIRV-Cross.git
  GIT_REMOTE_NAME origin
  GIT_TAG main
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR>
    ${cmake_conf_args}
    -DSPIRV_CROSS_SHARED=ON
    -DSPIRV_CROSS_CLI=OFF
    -DSPIRV_CROSS_ENABLE_TESTS=OFF
    -DCMAKE_CXX_FLAGS='${CMAKE_CXX_FLAGS} -D__USE_MINGW_ANSI_STDIO'
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA} -C <BINARY_DIR> install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

ExternalProject_Add_Step(
  spirv-cross symlink
  DEPENDEES install
  COMMAND
    ${CMAKE_COMMAND} -E create_symlink
    ${MINGW_INSTALL_PREFIX}/lib/pkgconfig/spirv-cross-c-shared.pc
    ${MINGW_INSTALL_PREFIX}/lib/pkgconfig/spirv-cross.pc)

force_rebuild_git(spirv-cross)
force_git_patch(spirv-cross)