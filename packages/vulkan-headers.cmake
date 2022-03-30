ExternalProject_Add(vulkan-headers
  GIT_REPOSITORY https://github.com/KhronosGroup/Vulkan-Headers.git
  GIT_SHALLOW 1
  GIT_REMOTE_NAME origin
  GIT_TAG main
  UPDATE_COMMAND ""
  CMAKE_ARGS
    -G Ninja
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_INSTALL_PREFIX=${MINGW_INSTALL_PREFIX}
  BUILD_COMMAND ""
  INSTALL_COMMAND ${NINJA} install
  LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_INSTALL 1
)

ExternalProject_Add_Step(vulkan-headers copy-wdk-headers
  DEPENDEES download
  DEPENDERS configure
  COMMAND ${CMAKE_COMMAND} -E copy  ${CMAKE_SOURCE_DIR}/toolchain/mingw-headers/d3dkmthk.h
                                    <SOURCE_DIR>/loader/d3dkmthk.h
  COMMAND ${CMAKE_COMMAND} -E copy  ${CMAKE_SOURCE_DIR}/toolchain/mingw-headers/d3dukmdt.h
                                    <SOURCE_DIR>/loader/d3dukmdt.h
  COMMENT "Copying extra mingw headers"
)

force_rebuild_git(vulkan-headers)
