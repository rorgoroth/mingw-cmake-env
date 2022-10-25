ExternalProject_Add(
  quake3e-urbanterror
  GIT_REPOSITORY https://github.com/omg-urt/urbanterror-slim.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  PATCH_COMMAND ${EXEC} git am ${CMAKE_CURRENT_SOURCE_DIR}/quake3e-0*.patch
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ""
  BUILD_IN_SOURCE 1
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

ExternalProject_Add_Step(
  quake3e-urbanterror strip-binary
  DEPENDEES build
  COMMAND
    ${EXEC} ${TARGET_ARCH}-strip -s
    <SOURCE_DIR>/build/release-mingw64-x86_64/urbanterror-slim.x64.exe
  COMMAND
    ${EXEC} ${TARGET_ARCH}-strip -s
    <SOURCE_DIR>/build/release-mingw64-x86_64/urbanterror-slim.ded.x64.exe)

ExternalProject_Add_Step(
  quake3e-urbanterror copy-binary
  DEPENDEES strip-binary
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <SOURCE_DIR>/build/release-mingw64-x86_64/urbanterror-slim.x64.exe
    ${CMAKE_CURRENT_BINARY_DIR}/quake3e-urbanterror-package/urbanterror-slim.x64.exe
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <SOURCE_DIR>/build/release-mingw64-x86_64/urbanterror-slim.ded.x64.exe
    ${CMAKE_CURRENT_BINARY_DIR}/quake3e-urbanterror-package/urbanterror-slim.ded.x64.exe)

ExternalProject_Add_Step(
  quake3e-urbanterror clean
  DEPENDEES copy-binary
  COMMAND git -C <SOURCE_DIR> clean -dfxq)

force_rebuild_git(quake3e-urbanterror)
