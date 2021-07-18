
ExternalProject_Add(quake3e
    DEPENDS
        gcc
    GIT_REPOSITORY https://github.com/rorgoroth/quake3e.git
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${EXEC} ${MAKE} PLATFORM=mingw32 ARCH=x86_64
    INSTALL_COMMAND ""
    BUILD_IN_SOURCE 1
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

ExternalProject_Add_Step(quake3e strip-binary
    DEPENDEES build
    COMMAND ${EXEC} ${TARGET_ARCH}-strip -s <SOURCE_DIR>/build/release-mingw32-x86_64/quake3e.x64.exe
    COMMAND ${EXEC} ${TARGET_ARCH}-strip -s <SOURCE_DIR>/build/release-mingw32-x86_64/quake3e.ded.x64.exe
    COMMENT "Stripping quake3e binaries"
)

ExternalProject_Add_Step(quake3e copy-binary
    DEPENDEES strip-binary
    COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/build/release-mingw32-x86_64/quake3e.x64.exe ${CMAKE_CURRENT_BINARY_DIR}/quake3e-package/quake3e.exe
    COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/build/release-mingw32-x86_64/quake3e.ded.x64.exe ${CMAKE_CURRENT_BINARY_DIR}/quake3e-package/quake3e.ded.exe
)

force_rebuild_git(quake3e)
extra_step(quake3e)
