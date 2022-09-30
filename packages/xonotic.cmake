ExternalProject_Add(
  xonotic
  DEPENDS gcc
  GIT_REPOSITORY https://github.com/rorgoroth/darkplaces-mingw-w64.git
  GIT_REMOTE_NAME origin
  GIT_TAG div0-stable
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ${MAKE} release DP_MAKE_TARGET=mingw WIN64RELEASE=1
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
    ${EXEC} ${TARGET_ARCH}-strip -s
    <SOURCE_DIR>/xonotic-dedicated.exe
  COMMAND
    ${EXEC} ${TARGET_ARCH}-strip -s
    <SOURCE_DIR>/xonotic.exe
  COMMAND
    ${EXEC} ${TARGET_ARCH}-strip -s
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
    <SOURCE_DIR>/xonotic.exe
    ${CMAKE_CURRENT_BINARY_DIR}/xonotic-package/xonotic.exe
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <SOURCE_DIR>/xonotic-sdl.exe
    ${CMAKE_CURRENT_BINARY_DIR}/xonotic-package/xonotic-sdl.exe)

ExternalProject_Add_Step(
  xonotic clean
  DEPENDEES copy-binary
  COMMAND git -C <SOURCE_DIR> clean -dfxq)

force_rebuild_git(xonotic)
