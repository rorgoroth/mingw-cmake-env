ExternalProject_Add(
  theora
  DEPENDS ogg
          vorbis
  GIT_REPOSITORY https://github.com/xiph/theora.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} <SOURCE_DIR>/autogen.sh && <SOURCE_DIR>/configure
    ${autotools_conf_args}
    --disable-examples
    --disable-oggtest
    --disable-sdltest
    --disable-vorbistest
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  BUILD_IN_SOURCE 1
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(theora)
