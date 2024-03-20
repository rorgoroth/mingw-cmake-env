ExternalProject_Add(
  xonotic
  DEPENDS libjpeg
          libsdl2
  GIT_REPOSITORY https://github.com/rorgoroth/darkplaces-mingw-w64.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ${MAKE} release DP_MAKE_TARGET=mingw WIN64RELEASE=1 SDL_CONFIG=${MINGW_INSTALL_PREFIX}/bin/sdl2-config
  INSTALL_COMMAND ""
  BUILD_IN_SOURCE 1
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

ExternalProject_Add_Step(
  xonotic strip-binary
  DEPENDEES build
  COMMAND
    ${EXEC} x86_64-w64-mingw32-strip -s
    <SOURCE_DIR>/xonotic-dedicated.exe
  COMMAND
    ${EXEC} x86_64-w64-mingw32-strip -s
    <SOURCE_DIR>/xonotic-sdl.exe)

ExternalProject_Add_Step(
  xonotic copy-binary
  DEPENDEES strip-binary
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <SOURCE_DIR>/Xonotic/SDL2.dll
    ${CMAKE_CURRENT_BINARY_DIR}/xonotic-package/SDL2.dll
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <SOURCE_DIR>/xonotic-dedicated.exe
    ${CMAKE_CURRENT_BINARY_DIR}/xonotic-package/xonotic-dedicated.exe
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <SOURCE_DIR>/xonotic-sdl.exe
    ${CMAKE_CURRENT_BINARY_DIR}/xonotic-package/xonotic-sdl.exe
  COMMAND
    ${CMAKE_COMMAND} -E copy_directory
    <SOURCE_DIR>/Xonotic/bin64
    ${CMAKE_CURRENT_BINARY_DIR}/xonotic-package/bin64/)

force_rebuild_git(xonotic)
clean_build(xonotic copy-binary)
