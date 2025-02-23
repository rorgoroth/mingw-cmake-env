ExternalProject_Add(
  vulkan-loader
  DEPENDS vulkan-headers
  URL https://github.com/KhronosGroup/Vulkan-Loader/archive/refs/tags/v1.4.309.tar.gz
  URL_HASH MD5=31c073cd0a87557bfa4dda7571acb6d1
  DOWNLOAD_EXTRACT_TIMESTAMP 1
  UPDATE_COMMAND ""
  PATCH_COMMAND ${EXEC} patch -p1 < ${CMAKE_CURRENT_SOURCE_DIR}/vulkan-loader-0001.patch
  CONFIGURE_COMMAND
    ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR>
    ${cmake_conf_args}
    -DVULKAN_HEADERS_INSTALL_DIR=${MINGW_INSTALL_PREFIX}
    -DBUILD_STATIC_LOADER=ON
    -DENABLE_WERROR=OFF
    -DUSE_GAS=ON
    -DCMAKE_C_FLAGS='${CMAKE_C_FLAGS} -D_WIN32_WINNT=0x0A00 -D__STDC_FORMAT_MACROS -DSTRSAFE_NO_DEPRECATE -Dparse_number=cjson_parse_number'
    -DCMAKE_CXX_FLAGS='${CMAKE_CXX_FLAGS} -D__USE_MINGW_ANSI_STDIO -D__STDC_FORMAT_MACROS -fpermissive -D_WIN32_WINNT=0x0A00'
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND
    COMMAND
      ${CMAKE_COMMAND} -E copy
      <BINARY_DIR>/loader/libvulkan.a
      ${MINGW_INSTALL_PREFIX}/lib/libvulkan.a
    COMMAND
      ${CMAKE_COMMAND} -E copy
      <BINARY_DIR>/loader/vulkan_own.pc
      ${MINGW_INSTALL_PREFIX}/lib/pkgconfig/vulkan.pc
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

