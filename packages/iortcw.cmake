ExternalProject_Add(
  iortcw
  DEPENDS gcc
  GIT_REPOSITORY https://github.com/iortcw/iortcw.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  PATCH_COMMAND ${EXEC} git am ${CMAKE_CURRENT_SOURCE_DIR}/iortcw-*.patch
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ${MAKE} PLATFORM=mingw64 ARCH=x86_64 -C <SOURCE_DIR>/SP
  INSTALL_COMMAND ""
  BUILD_IN_SOURCE 1
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

ExternalProject_Add_Step(
  iortcw symlink
  DEPENDEES build
  COMMAND
    ${CMAKE_COMMAND} -E create_symlink
    <SOURCE_DIR>/SP/build/release-mingw64-x86_64/
    <SOURCE_DIR>/SP-BUILD)

ExternalProject_Add_Step(
  iortcw copy-binary
  DEPENDEES symlink
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <SOURCE_DIR>/SP-BUILD/ioWolfSP.x64.exe
    ${CMAKE_CURRENT_BINARY_DIR}/iortcw-package/ioWolfSP.x64.exe
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <SOURCE_DIR>/SP-BUILD/OpenAL64.dll
    ${CMAKE_CURRENT_BINARY_DIR}/iortcw-package/OpenAL64.dll
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <SOURCE_DIR>/SP-BUILD/renderer_sp_opengl1_x64.dll
    ${CMAKE_CURRENT_BINARY_DIR}/iortcw-package/renderer_sp_opengl1_x64.dll
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <SOURCE_DIR>/SP-BUILD/SDL264.dll
    ${CMAKE_CURRENT_BINARY_DIR}/iortcw-package/SDL264.dll
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <SOURCE_DIR>/SP-BUILD/main/cgame_sp_x64.dll
    ${CMAKE_CURRENT_BINARY_DIR}/iortcw-package/main/cgame_sp_x64.dll
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <SOURCE_DIR>/SP-BUILD/main/qagame_sp_x64.dll
    ${CMAKE_CURRENT_BINARY_DIR}/iortcw-package/main/qagame_sp_x64.dll
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <SOURCE_DIR>/SP-BUILD/main/ui_sp_x64.dll
    ${CMAKE_CURRENT_BINARY_DIR}/iortcw-package/main/ui_sp_x64.dll)

ExternalProject_Add_Step(
  iortcw clean
  DEPENDEES copy-binary
  COMMAND git -C <SOURCE_DIR> clean -dfxq)

force_rebuild_git(iortcw)
