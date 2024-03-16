ExternalProject_Add(
  bzip2
  GIT_REPOSITORY https://gitlab.com/bzip2/bzip2.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR> -G Ninja
    -DCMAKE_INSTALL_PREFIX=${MINGW_INSTALL_PREFIX}
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE}
    -DCMAKE_BUILD_TYPE=Release
    -DENABLE_SHARED_LIB=OFF
    -DENABLE_STATIC_LIB=ON
    -DENABLE_LIB_ONLY=OFF
    -DENABLE_APP=OFF
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA} -C <BINARY_DIR> install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

ExternalProject_Add_Step(
  bzip2 symlink
  DEPENDEES install
  COMMAND
    ${CMAKE_COMMAND} -E create_symlink
    ${MINGW_INSTALL_PREFIX}/lib/libbz2_static.a
    ${MINGW_INSTALL_PREFIX}/lib/libbz2.a)

force_rebuild_git(bzip2)
clean_build(bzip2 install)
