ExternalProject_Add(
  glew
  DEPENDS zlib
  GIT_REPOSITORY https://github.com/Perlmint/glew-cmake.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR>
    ${cmake_conf_args}
    -DGLEW_OSMESA=OFF
    -DONLY_LIBS=ON
    -DUSE_GLU=OFF
    -Dglew-cmake_BUILD_SHARED=OFF
    -Dglew-cmake_BUILD_STATIC=ON
  BUILD_COMMAND ${NINJA}
  INSTALL_COMMAND ${NINJA} install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(glew)
