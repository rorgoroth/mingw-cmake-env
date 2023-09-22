ExternalProject_Add(
  libxml2
  DEPENDS libiconv
  GIT_REPOSITORY https://github.com/GNOME/libxml2.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} <SOURCE_DIR>/configure
    --host=x86_64-w64-mingw32
    --prefix=${MINGW_INSTALL_PREFIX}
    --disable-shared
    --enable-static
    --with-minimum
    --with-threads
    --with-tree
    --without-lzma
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(libxml2)
autogen(libxml2)
