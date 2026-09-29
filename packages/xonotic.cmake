ExternalProject_Add(
  xonotic
  DEPENDS libjpeg
          sdl2
          zlib
  GIT_REPOSITORY https://github.com/rorgoroth/darkplaces-mingw-w64.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ${MAKE} release release DP_LINK_SDL=static SDL_CONFIG=${MINGW_INSTALL_PREFIX}/bin/sdl2-config
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
    ${CMAKE_CURRENT_BINARY_DIR}/xonotic-package/xonotic-sdl.exe)

force_rebuild_git(xonotic)
