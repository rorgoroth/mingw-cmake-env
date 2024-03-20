ExternalProject_Add(
  vulkan-loader
  DEPENDS vulkan-headers
  URL https://github.com/KhronosGroup/Vulkan-Loader/archive/refs/tags/v1.3.280.tar.gz
  URL_HASH MD5=c13920b29b0e9b44998250d1cd8f6e67
  DOWNLOAD_EXTRACT_TIMESTAMP 1
  UPDATE_COMMAND ""
  PATCH_COMMAND ${EXEC} patch -p1 < ${CMAKE_CURRENT_SOURCE_DIR}/vulkan-loader-0001.patch
  CONFIGURE_COMMAND
    ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR> -G Ninja
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_INSTALL_PREFIX=${MINGW_INSTALL_PREFIX}
    -DVULKAN_HEADERS_INSTALL_DIR=${MINGW_INSTALL_PREFIX}
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE}
    -DBUILD_TESTS=OFF
    -DBUILD_STATIC_LOADER=ON
    -DENABLE_WERROR=OFF
    -DCMAKE_C_FLAGS='${CMAKE_C_FLAGS} -D_WIN32_WINNT=0x0A00 -D__STDC_FORMAT_MACROS -DSTRSAFE_NO_DEPRECATE -Dparse_number=cjson_parse_number'
    -DCMAKE_CXX_FLAGS='${CMAKE_CXX_FLAGS} -D__USE_MINGW_ANSI_STDIO -D__STDC_FORMAT_MACROS -fpermissive -D_WIN32_WINNT=0x0A00'
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${CMAKE_COMMAND} -E copy <BINARY_DIR>/loader/libvulkan.a ${MINGW_INSTALL_PREFIX}/lib/libvulkan.a
          COMMAND ${CMAKE_COMMAND} -E copy <BINARY_DIR>/loader/vulkan_own.pc ${MINGW_INSTALL_PREFIX}/lib/pkgconfig/vulkan.pc
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

clean_build(vulkan-loader install)
