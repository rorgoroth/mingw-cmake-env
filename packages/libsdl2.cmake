ExternalProject_Add(
  libsdl2
  URL https://github.com/libsdl-org/SDL/releases/download/release-2.30.4/SDL2-2.30.4.tar.gz
  URL_HASH MD5=89166c920ab657476bf80f6112cd7028
  DOWNLOAD_EXTRACT_TIMESTAMP 1
  CONFIGURE_COMMAND
    ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR>
    ${cmake_conf_args}
    -DSDL_HAPTIC=OFF
    -DSDL_JOYSTICK=OFF
    -DSDL_XINPUT=OFF
    -DSDL_STATIC=ON
    -DSDL_TEST=OFF
    -DSDL_THREADS=ON
    -DSDL_VULKAN=ON
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA} install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

