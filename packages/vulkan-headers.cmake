ExternalProject_Add(
  vulkan-headers
  URL https://github.com/KhronosGroup/Vulkan-Headers/archive/refs/tags/v1.4.350.tar.gz
  URL_HASH MD5=b991fd3dafdea52c8108f43634c69c2e
  DOWNLOAD_EXTRACT_TIMESTAMP 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR>
    ${cmake_conf_args}
    -DVULKAN_HEADERS_ENABLE_MODULE=OFF
  BUILD_COMMAND ""
  INSTALL_COMMAND ${NINJA} install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)
