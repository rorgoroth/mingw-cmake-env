ExternalProject_Add(
  vulkan-headers
  URL https://github.com/KhronosGroup/Vulkan-Headers/archive/refs/tags/v1.3.270.tar.gz
  URL_HASH MD5=805bde4c23197b86334cee5c2cf69d8e
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR> -G Ninja
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_INSTALL_PREFIX=${MINGW_INSTALL_PREFIX}
  BUILD_COMMAND ""
  INSTALL_COMMAND ${NINJA} install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

ExternalProject_Add_Step(
  vulkan-headers copy-wdk-headers
  DEPENDEES download
  DEPENDERS configure
  COMMAND
    ${CMAKE_COMMAND} -E copy
    ${CMAKE_CURRENT_SOURCE_DIR}/vulkan-headers-d3dkmthk.h
    <SOURCE_DIR>/loader/d3dkmthk.h
  COMMAND
    ${CMAKE_COMMAND} -E copy
    ${CMAKE_CURRENT_SOURCE_DIR}/vulkan-headers-d3dukmdt.h
    <SOURCE_DIR>/loader/d3dukmdt.h
  COMMENT "vulkan-headers: Copying extra mingw headers")
