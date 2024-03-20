ExternalProject_Add(
  quake3e-openarena
  DEPENDS vorbis
          zlib
          zstd
  GIT_REPOSITORY https://github.com/rorgoroth/Quake3e-OpenArena.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  PATCH_COMMAND ""
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
  quake3e-openarena strip-binary
  DEPENDEES build
  COMMAND
    ${EXEC} x86_64-w64-mingw32-strip -s
    <SOURCE_DIR>/build/release-mingw64-x86_64/quake3e.x64.exe
  COMMAND
    ${EXEC} x86_64-w64-mingw32-strip -s
    <SOURCE_DIR>/build/release-mingw64-x86_64/quake3e.ded.x64.exe)

ExternalProject_Add_Step(
  quake3e-openarena copy-binary
  DEPENDEES strip-binary
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <SOURCE_DIR>/build/release-mingw64-x86_64/quake3e.x64.exe
    ${CMAKE_CURRENT_BINARY_DIR}/quake3e-openarena-package/quake3e.x64.exe
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <SOURCE_DIR>/build/release-mingw64-x86_64/quake3e.ded.x64.exe
    ${CMAKE_CURRENT_BINARY_DIR}/quake3e-openarena-package/quake3e.ded.x64.exe)

force_rebuild_git(quake3e-openarena)
clean_build(quake3e-openarena copy-binary)
