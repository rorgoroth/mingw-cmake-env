ExternalProject_Add(shaderc
  GIT_REPOSITORY https://github.com/rorgoroth/mpv-shaderc.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR>
    -G Ninja
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_INSTALL_PREFIX=${MINGW_INSTALL_PREFIX}
    -DCMAKE_TOOLCHAIN_FILE=<SOURCE_DIR>/cmake/linux-mingw-toolchain.cmake
    -DSHADERC_SKIP_TESTS=ON
    -DSHADERC_SKIP_SPVC=ON
    -DSHADERC_SKIP_INSTALL=ON
    -DSHADERC_SKIP_EXAMPLES=ON
    -DMINGW_COMPILER_PREFIX=${TARGET_ARCH}
    -DCMAKE_CXX_FLAGS='${CMAKE_CXX_FLAGS} -std=c++11'
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ""
  LOG_DOWNLOAD 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

ExternalProject_Add_Step(shaderc manual-install
  DEPENDEES build
  COMMAND ${CMAKE_COMMAND} -E copy_directory  <SOURCE_DIR>/libshaderc/include/shaderc
                                              ${MINGW_INSTALL_PREFIX}/include/shaderc
  COMMAND ${CMAKE_COMMAND} -E copy  <BINARY_DIR>/libshaderc/libshaderc_combined.a
                                    ${MINGW_INSTALL_PREFIX}/lib/libshaderc_combined.a
  COMMAND ${CMAKE_COMMAND} -E copy  <BINARY_DIR>/shaderc_combined.pc
                                    ${MINGW_INSTALL_PREFIX}/lib/pkgconfig/shaderc_combined.pc
  COMMENT "Manually installing"
)

force_rebuild_git(shaderc)
