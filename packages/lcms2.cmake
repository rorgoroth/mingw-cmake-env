ExternalProject_Add(
  lcms2
  DEPENDS libjpeg
          zlib
  GIT_REPOSITORY https://github.com/mm2/Little-CMS.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} autoreconf -fi && <SOURCE_DIR>/configure
    --host=${TARGET_ARCH}
    --prefix=${MINGW_INSTALL_PREFIX}
    --disable-shared
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  BUILD_IN_SOURCE 1
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(lcms2)
