ExternalProject_Add(
  winrt-headers
  GIT_REPOSITORY https://github.com/rorgoroth/winrt-headers.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND
    ${CMAKE_COMMAND} -E copy_directory
    <SOURCE_DIR>/include/winrt
    ${MINGW_INSTALL_PREFIX}/include/winrt
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(winrt-headers)
