ExternalProject_Add(
  libpng
  DEPENDS zlib
  GIT_REPOSITORY https://github.com/glennrp/libpng.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR> -G Ninja
    -DCMAKE_INSTALL_PREFIX=${MINGW_INSTALL_PREFIX}
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE}
    -DCMAKE_BUILD_TYPE=Release
    -DPNG_BUILD_ZLIB=OFF
    -DPNG_DEBUG=OFF
    -DPNG_EXECUTABLES=ON
    -DPNG_FRAMEWORK=OFF
    -DPNG_HARDWARE_OPTIMIZATIONS=ON
    -DPNG_INTEL_SSE=on
    -DPNG_SHARED=OFF
    -DPNG_STATIC=ON
    -DPNG_TESTS=OFF
    -DPNG_TOOLS=OFF
    -Dld-version-script=ON
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA} -C <BINARY_DIR> install
  COMMAND
    ${CMAKE_COMMAND} -E create_symlink
    ${MINGW_INSTALL_PREFIX}/bin/libpng-config
    ${CMAKE_INSTALL_PREFIX}/bin/libpng-config
  COMMAND
    ${CMAKE_COMMAND} -E create_symlink
    ${MINGW_INSTALL_PREFIX}/bin/libpng16-config
    ${CMAKE_INSTALL_PREFIX}/bin/libpng16-config
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(libpng)
clean_build(libpng install)
