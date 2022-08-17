ExternalProject_Add(
  quake3e
  DEPENDS gcc
  GIT_REPOSITORY https://github.com/rorgoroth/Quake3e.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
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
  quake3e strip-binary
  DEPENDEES build
  COMMAND
    ${EXEC} ${TARGET_ARCH}-strip -s
    <SOURCE_DIR>/build/release-mingw64-x86_64/quake3e.exe
  COMMAND
    ${EXEC} ${TARGET_ARCH}-strip -s
    <SOURCE_DIR>/build/release-mingw64-x86_64/quake3e-server.exe
  COMMENT "Stripping quake3e binaries")

ExternalProject_Add_Step(
  quake3e copy-binary
  DEPENDEES strip-binary
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <SOURCE_DIR>/build/release-mingw64-x86_64/quake3e.exe
    ${CMAKE_CURRENT_BINARY_DIR}/quake3e-package/quake3e.exe
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <SOURCE_DIR>/build/release-mingw64-x86_64/quake3e-server.exe
    ${CMAKE_CURRENT_BINARY_DIR}/quake3e-package/quake3e-server.exe)

force_rebuild_git(quake3e)
