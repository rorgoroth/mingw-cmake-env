ExternalProject_Add(
  vulkan-headers
  URL https://github.com/KhronosGroup/Vulkan-Headers/archive/refs/tags/v1.3.285.tar.gz
  URL_HASH MD5=7032af3f79969c1f00dda518fac96087
  DOWNLOAD_EXTRACT_TIMESTAMP 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR>
    ${cmake_conf_args}
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

