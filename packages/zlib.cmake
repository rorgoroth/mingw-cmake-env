ExternalProject_Add(zlib
  GIT_REPOSITORY https://github.com/madler/zlib.git
  GIT_REMOTE_NAME origin
  GIT_TAG develop
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  PATCH_COMMAND ${EXEC} patch -p1 < ${CMAKE_CURRENT_SOURCE_DIR}/zlib-1-win32-static.patch
  CONFIGURE_COMMAND ${EXEC} CHOST=${TARGET_ARCH} <SOURCE_DIR>/configure
    --prefix=${MINGW_INSTALL_PREFIX}
    --static
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(zlib)
