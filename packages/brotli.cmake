ExternalProject_Add(
  brotli
  URL https://github.com/google/brotli/archive/refs/tags/v1.1.0.tar.gz
  URL_HASH MD5=3a6a3dba82a3604792d3cb0bd41bca60
  DOWNLOAD_EXTRACT_TIMESTAMP 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR> -G Ninja
    -DCMAKE_INSTALL_PREFIX=${MINGW_INSTALL_PREFIX}
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE}
    -DCMAKE_BUILD_TYPE=Release
    -DBUILD_SHARED_LIBS=OFF
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA} -C <BINARY_DIR> install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)
clean_build(brotli install)
