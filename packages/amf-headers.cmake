ExternalProject_Add(
  amf-headers
  GIT_REPOSITORY https://github.com/rorgoroth/amf-headers.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND
    ${CMAKE_COMMAND} -E copy_directory
    <SOURCE_DIR>/components
    ${MINGW_INSTALL_PREFIX}/include/AMF/components
  COMMAND
    ${CMAKE_COMMAND} -E copy_directory
    <SOURCE_DIR>/core
    ${MINGW_INSTALL_PREFIX}/include/AMF/core
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(amf-headers)
