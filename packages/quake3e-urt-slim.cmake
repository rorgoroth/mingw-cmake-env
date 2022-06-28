ExternalProject_Add(
  quake3e-urt-slim
  DEPENDS gcc
  GIT_REPOSITORY https://github.com/omg-urt/urbanterror-slim.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  PATCH_COMMAND ${EXEC} git am ${CMAKE_CURRENT_SOURCE_DIR}/quake3e-urt-slim-0*.patch
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ${MAKE} PLATFORM=mingw64 ARCH=x86_64
  INSTALL_COMMAND ""
  BUILD_IN_SOURCE 1
  LOG_DOWNLOAD 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

ExternalProject_Add_Step(
  quake3e-urt-slim strip-binary
  DEPENDEES build
  COMMAND
    ${EXEC} ${TARGET_ARCH}-strip -s
    <SOURCE_DIR>/build/release-mingw64-x86_64/urbanterror-slim.x64.exe
  COMMAND
    ${EXEC} ${TARGET_ARCH}-strip -s
    <SOURCE_DIR>/build/release-mingw64-x86_64/urbanterror-slim.ded.x64.exe
  COMMENT "Stripping quake3e-urt-slim binaries")

ExternalProject_Add_Step(
  quake3e-urt-slim copy-binary
  DEPENDEES strip-binary
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <SOURCE_DIR>/build/release-mingw64-x86_64/urbanterror-slim.x64.exe
    ${CMAKE_CURRENT_BINARY_DIR}/quake3e-urt-slim-package/urbanterror-slim.x64.exe
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <SOURCE_DIR>/build/release-mingw64-x86_64/urbanterror-slim.ded.x64.exe
    ${CMAKE_CURRENT_BINARY_DIR}/quake3e-urt-slim-package/urbanterror-slim.ded.x64.exe
)

force_rebuild_git(quake3e-urt-slim)
