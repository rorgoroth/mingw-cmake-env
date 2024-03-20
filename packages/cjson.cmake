ExternalProject_Add(
  cjson
  GIT_REPOSITORY https://github.com/DaveGamble/cJSON.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR> -G Ninja
    -DCMAKE_INSTALL_PREFIX=${MINGW_INSTALL_PREFIX}
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE}
    -DBUILD_SHARED_AND_STATIC_LIBS=OFF
    -DBUILD_SHARED_LIBS=OFF
    -DENABLE_CJSON_TEST=OFF
    -DENABLE_CJSON_UNINSTALL=OFF
    -DENABLE_CJSON_UTILS=ON
    -DENABLE_CJSON_VERSION_SO=ON
    -DENABLE_CUSTOM_COMPILER_FLAGS=ON
    -DENABLE_FUZZING=OFF
    -DENABLE_HIDDEN_SYMBOLS=OFF
    -DENABLE_LOCALES=ON
    -DENABLE_PUBLIC_SYMBOLS=ON
    -DENABLE_SAFE_STACK=OFF
    -DENABLE_SANITIZERS=OFF
    -DENABLE_TARGET_EXPORT=OFF
    -DENABLE_VALGRIND=OFF
  BUILD_COMMAND ${NINJA}
  INSTALL_COMMAND ${NINJA} install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(cjson)
clean_build(cjson install)
