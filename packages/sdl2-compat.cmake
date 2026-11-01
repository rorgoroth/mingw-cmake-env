ExternalProject_Add(
  sdl2-compat
  DEPENDS sdl3
  URL https://github.com/libsdl-org/sdl2-compat/releases/download/release-2.32.74/sdl2-compat-2.32.74.tar.gz
  URL_HASH SHA256=ec68abde77e2e459c8abc4f9587b8976b5d2a657b2bfda2fb3a079b0f8924588
  DOWNLOAD_EXTRACT_TIMESTAMP 1
  CONFIGURE_COMMAND
    ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR>
    ${cmake_conf_args}
    -DSDL2COMPAT_ASAN=OFF
    -DSDL2COMPAT_INSTALL=ON
    -DSDL2COMPAT_INSTALL_CPACK=OFF
    -DSDL2COMPAT_INSTALL_TESTS=OFF
    -DSDL2COMPAT_STATIC=OFF
    -DSDL2COMPAT_TESTS=OFF
    -DSDL2COMPAT_WERROR=OFF
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA} install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

ExternalProject_Add_Step(
  sdl2-compat pkgconfig-alias
  DEPENDEES install
  COMMAND
    ${CMAKE_COMMAND} -E copy
    ${MINGW_INSTALL_PREFIX}/lib/pkgconfig/sdl2-compat.pc
    ${MINGW_INSTALL_PREFIX}/lib/pkgconfig/sdl2.pc)
