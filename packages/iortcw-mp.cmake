ExternalProject_Add(iortcw-mp
  DEPENDS iortcw
  GIT_REPOSITORY https://github.com/rorgoroth/iortcw.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  PATCH_COMMAND ${EXEC} git am ${CMAKE_CURRENT_SOURCE_DIR}/iortcw-0*.patch
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ${EXEC} ${MAKE} PLATFORM=mingw64 ARCH=x86_64 -C <SOURCE_DIR>/MP
  INSTALL_COMMAND ""
  BUILD_IN_SOURCE 1
  LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

ExternalProject_Add_Step(iortcw-mp symlink
  DEPENDEES build
  COMMAND ${CMAKE_COMMAND} -E create_symlink <SOURCE_DIR>/MP/build/release-mingw64-x86_64/ <SOURCE_DIR>/MP-BUILD
)

ExternalProject_Add_Step(iortcw-mp copy-binary
  DEPENDEES symlink
  COMMAND ${CMAKE_COMMAND} -E copy  <SOURCE_DIR>/MP-BUILD/ioWolfMP.x64.exe
                                    ${CMAKE_CURRENT_BINARY_DIR}/iortcw-package/ioWolfMP.x64.exe
  COMMAND ${CMAKE_COMMAND} -E copy  <SOURCE_DIR>/MP-BUILD/ioWolfDED.x64.exe
                                    ${CMAKE_CURRENT_BINARY_DIR}/iortcw-package/ioWolfDED.x64.exe
  COMMAND ${CMAKE_COMMAND} -E copy  <SOURCE_DIR>/MP-BUILD/renderer_mp_opengl1_x64.dll
                                    ${CMAKE_CURRENT_BINARY_DIR}/iortcw-package/renderer_mp_opengl1_x64.dll
  COMMAND ${CMAKE_COMMAND} -E copy  <SOURCE_DIR>/MP-BUILD/main/cgame_mp_x64.dll
                                    ${CMAKE_CURRENT_BINARY_DIR}/iortcw-package/main/cgame_mp_x64.dll
  COMMAND ${CMAKE_COMMAND} -E copy  <SOURCE_DIR>/MP-BUILD/main/qagame_mp_x64.dll
                                    ${CMAKE_CURRENT_BINARY_DIR}/iortcw-package/main/qagame_mp_x64.dll
  COMMAND ${CMAKE_COMMAND} -E copy  <SOURCE_DIR>/MP-BUILD/main/ui_mp_x64.dll
                                    ${CMAKE_CURRENT_BINARY_DIR}/iortcw-package/main/ui_mp_x64.dll
)

force_rebuild_git(iortcw-mp)
