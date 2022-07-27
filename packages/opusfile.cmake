ExternalProject_Add(
  opusfile
  DEPENDS opus
          ogg
  GIT_REPOSITORY https://github.com/xiph/opusfile.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND ${EXEC} <SOURCE_DIR>/autogen.sh
  COMMAND
    ${EXEC} <SOURCE_DIR>/configure
    --host=${TARGET_ARCH}
    --prefix=${MINGW_INSTALL_PREFIX}
    --disable-doc
    --disable-examples
    --disable-http
    --disable-shared
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(opusfile)
autogen(opusfile)
