
ExternalProject_Add(quake3e-urt
  DEPENDS
    gcc
  GIT_REPOSITORY https://github.com/omg-urt/urbanterror-slim.git
  UPDATE_COMMAND ""
  PATCH_COMMAND ${EXEC} git am ${CMAKE_CURRENT_SOURCE_DIR}/quake3e-urt*.patch
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ${EXEC} ${MAKE} PLATFORM=mingw32 ARCH=x86_64
  INSTALL_COMMAND ""
  BUILD_IN_SOURCE 1
  LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

ExternalProject_Add_Step(quake3e-urt strip-binary
  DEPENDEES build
  COMMAND ${EXEC} ${TARGET_ARCH}-strip -s <SOURCE_DIR>/build/release-mingw32-x86_64/quake3e-urt.x64.exe
  COMMAND ${EXEC} ${TARGET_ARCH}-strip -s <SOURCE_DIR>/build/release-mingw32-x86_64/quake3e-urt.ded.x64.exe
  COMMENT "Stripping quake3e-urt binaries"
)

ExternalProject_Add_Step(quake3e-urt copy-binary
  DEPENDEES strip-binary
  COMMAND ${CMAKE_COMMAND} -E copy  <SOURCE_DIR>/build/release-mingw32-x86_64/quake3e-urt.x64.exe 
                                    ${CMAKE_CURRENT_BINARY_DIR}/quake3e-urt-package/quake3e-urt.exe
  COMMAND ${CMAKE_COMMAND} -E copy  <SOURCE_DIR>/build/release-mingw32-x86_64/quake3e-urt.ded.x64.exe 
                                    ${CMAKE_CURRENT_BINARY_DIR}/quake3e-urt-package/quake3e-urt.ded.exe
)

force_rebuild_git(quake3e-urt)
extra_step(quake3e-urt)
