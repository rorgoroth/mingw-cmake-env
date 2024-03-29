  ExternalProject_Add(
  shaderc
  GIT_REPOSITORY https://github.com/rorgoroth/mpv-shaderc.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR> -G Ninja
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_CXX_FLAGS='${CMAKE_CXX_FLAGS} -std=c++17'
    -DCMAKE_INSTALL_PREFIX=${MINGW_INSTALL_PREFIX}
    -DCMAKE_TOOLCHAIN_FILE=<SOURCE_DIR>/cmake/linux-mingw-toolchain.cmake
    -DMINGW_COMPILER_PREFIX=x86_64-w64-mingw32
    -DBUILD_EXTERNAL=OFF
    -DBUILD_SHARED_LIBS=OFF
    -DBUILD_TESTING=OFF
    -DDISABLE_EXCEPTIONS=OFF
    -DDISABLE_RTTI=OFF
    -DENABLE_CTEST=OFF
    -DENABLE_EXCEPTIONS_ON_MSVC=OFF
    -DENABLE_EXCEPTIONS=OFF
    -DENABLE_GLSLANG_BINARIES=OFF
    -DENABLE_GLSLANG_BINARIES=OFF
    -DENABLE_GLSLANG_JS=OFF
    -DENABLE_HLSL=ON
    -DENABLE_OPT=OFF
    -DENABLE_PCH=OFF
    -DENABLE_RTTI=OFF
    -DENABLE_SPVREMAPPER=ON
    -Dgtest_force_shared_crt=ON
    -DOVERRIDE_MSVCCRT=ON
    -DSHADERC_ENABLE_WERROR_COMPILE=OFF
    -DSHADERC_ENABLE_WGSL_OUTPUT=OFF
    -DSHADERC_SKIP_COPYRIGHT_CHECK=ON
    -DSHADERC_SKIP_EXAMPLES=ON
    -DSHADERC_SKIP_INSTALL=ON
    -DSHADERC_SKIP_SPVC=ON
    -DSHADERC_SKIP_TESTS=ON
    -DSPIRV_ALLOW_TIMERS=ON
    -DSPIRV_BUILD_COMPRESSION=OFF
    -DSPIRV_BUILD_FUZZER=OFF
    -DSPIRV_BUILD_LIBFUZZER_TARGETS=OFF
    -DSPIRV_CHECK_CONTEXT=OFF
    -DSPIRV_COLOR_TERMINAL=ON
    -DSPIRV_CROSS_EXCEPTIONS_TO_ASSE=OFF
    -DSPIRV_HEADERS_SKIP_EXAMPLES=ON
    -DSPIRV_HEADERS_SKIP_INSTALL=OFF
    -DSPIRV_LOG_DEBUG=OFF
    -DSPIRV_SKIP_EXECUTABLES=OFF
    -DSPIRV_SKIP_EXECUTABLES=ON
    -DSPIRV_SKIP_TESTS=ON
    -DSPIRV_TOOLS_BUILD_STATIC=ON
    -DSPIRV_TOOLS_INSTALL_EMACS_HELP=OFF
    -DSPIRV_TOOLS_LIBRARY_TYPE=STATIC
    -DSPIRV_WARN_EVERYTHING=OFF
    -DSPIRV_WERROR=OFF
    -DUSE_CCACHE=OFF
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ""
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

ExternalProject_Add_Step(
  shaderc manual-install
  DEPENDEES build
  COMMAND
    ${CMAKE_COMMAND} -E copy_directory
    <SOURCE_DIR>/libshaderc/include/shaderc
    ${MINGW_INSTALL_PREFIX}/include/shaderc
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <BINARY_DIR>/libshaderc/libshaderc_combined.a
    ${MINGW_INSTALL_PREFIX}/lib/libshaderc_combined.a
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <BINARY_DIR>/shaderc_combined.pc
    ${MINGW_INSTALL_PREFIX}/lib/pkgconfig/shaderc.pc
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <BINARY_DIR>/shaderc_combined.pc
    ${MINGW_INSTALL_PREFIX}/lib/pkgconfig/shaderc_combined.pc
  COMMENT "Manually installing")

force_rebuild_git(shaderc)
