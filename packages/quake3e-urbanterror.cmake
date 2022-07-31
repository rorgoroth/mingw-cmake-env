ExternalProject_Add(
  quake3e-urbanterror
  DEPENDS gcc
  GIT_REPOSITORY https://github.com/rorgoroth/Quake3e-UrbanTerror.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  PATCH_COMMAND ""
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ${MAKE} PLATFORM=mingw64 ARCH=x86_64
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
    <SOURCE_DIR>/build/release-mingw64-x86_64/q3e-urt.exe
  COMMAND
    ${EXEC} ${TARGET_ARCH}-strip -s
    <SOURCE_DIR>/build/release-mingw64-x86_64/q3e-urt-server.exe
  COMMENT "Stripping quake3e-urbanterror binaries")

ExternalProject_Add_Step(
  quake3e-urbanterror copy-binary
  DEPENDEES strip-binary
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <SOURCE_DIR>/build/release-mingw64-x86_64/q3e-urt.exe
    ${CMAKE_CURRENT_BINARY_DIR}/quake3e-urbanterror-package/q3e-urt.exe
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <SOURCE_DIR>/build/release-mingw64-x86_64/q3e-urt-server.exe
    ${CMAKE_CURRENT_BINARY_DIR}/quake3e-urbanterror-package/q3e-urt-server.exe
)

force_rebuild_git(quake3e-urbanterror)
