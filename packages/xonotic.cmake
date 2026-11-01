ExternalProject_Add(
  xonotic
  DEPENDS libjpeg
          sdl2-compat
          zlib
  GIT_REPOSITORY https://github.com/rorgoroth/darkplaces-mingw-w64.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ${MAKE} release DP_LINK_SDL=shared SDL_CONFIG=${MINGW_INSTALL_PREFIX}/bin/sdl2-config
  INSTALL_COMMAND ""
  BUILD_IN_SOURCE 1
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

ExternalProject_Add_Step(
  xonotic copy-binary
  DEPENDEES build
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <SOURCE_DIR>/xonotic-dedicated.exe
    ${CMAKE_CURRENT_BINARY_DIR}/xonotic-package/xonotic-dedicated.exe
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <SOURCE_DIR>/xonotic-sdl.exe
    ${CMAKE_CURRENT_BINARY_DIR}/xonotic-package/xonotic-sdl.exe
  COMMAND
    ${CMAKE_COMMAND} -E copy
    ${MINGW_INSTALL_PREFIX}/bin/SDL2.dll
    ${CMAKE_CURRENT_BINARY_DIR}/xonotic-package/SDL2.dll
  COMMAND
    ${CMAKE_COMMAND} -E copy
    ${MINGW_INSTALL_PREFIX}/bin/SDL3.dll
    ${CMAKE_CURRENT_BINARY_DIR}/xonotic-package/SDL3.dll)

force_rebuild_git(xonotic)
