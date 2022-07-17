ExternalProject_Add(
  vulkan-headers
  URL https://github.com/KhronosGroup/Vulkan-Headers/archive/refs/tags/v1.3.221.tar.gz
  URL_HASH MD5=e8540dbf49730fe2b72af6a43d073b43
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR> -G Ninja
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_INSTALL_PREFIX=${MINGW_INSTALL_PREFIX}
  BUILD_COMMAND ""
  INSTALL_COMMAND ${NINJA} install
  LOG_DOWNLOAD 1
  LOG_CONFIGURE 1
  LOG_INSTALL 1)

ExternalProject_Add_Step(
  vulkan-headers copy-wdk-headers
  DEPENDEES download
  DEPENDERS configure
  COMMAND
    ${CMAKE_COMMAND} -E copy
    ${CMAKE_SOURCE_DIR}/toolchain/mingw-headers/d3dkmthk.h
    <SOURCE_DIR>/loader/d3dkmthk.h
  COMMAND
    ${CMAKE_COMMAND} -E copy
    ${CMAKE_SOURCE_DIR}/toolchain/mingw-headers/d3dukmdt.h
    <SOURCE_DIR>/loader/d3dukmdt.h
  COMMENT "Copying extra mingw headers")
