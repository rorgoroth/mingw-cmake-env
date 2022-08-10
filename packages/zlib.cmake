ExternalProject_Add(
  zlib
  GIT_REPOSITORY https://github.com/zlib-ng/zlib-ng.git
  GIT_REMOTE_NAME origin
  GIT_TAG develop
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  PATCH_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR> -G Ninja
    -DCMAKE_INSTALL_PREFIX=${MINGW_INSTALL_PREFIX}
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE}
    -DCMAKE_BUILD_TYPE=Release
    -DWITH_AVX512=ON
    -DWITH_AVX512VNNI=ON
    -DWITH_BENCHMARK_APPS=OFF
    -DWITH_BENCHMARKS=OFF
    -DWITH_CODE_COVERAGE=OFF
    -DWITH_FUZZERS=OFF
    -DWITH_GZFILEOP=ON
    -DWITH_MAINTAINER_WARNINGS=OFF
    -DWITH_NATIVE_INSTRUCTIONS=OFF
    -DWITH_NEW_STRATEGIES=ON
    -DWITH_OPTIM=ON
    -DZLIB_COMPAT=ON
    -DZLIB_ENABLE_TESTS=OFF
  BUILD_COMMAND ${NINJA}
  INSTALL_COMMAND ${NINJA} install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(zlib)
