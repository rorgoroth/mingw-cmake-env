ExternalProject_Add(
  freetype2
  DEPENDS bzip2
          libpng
          zlib
  GIT_REPOSITORY https://github.com/freetype/freetype.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} meson <BINARY_DIR> <SOURCE_DIR>
    --prefix=${MINGW_INSTALL_PREFIX}
    --libdir=${MINGW_INSTALL_PREFIX}/lib
    --cross-file=${MESON_CROSS}
    --buildtype=release
    --default-library=static
    -Dbzip2=enabled
    -Dharfbuzz=disabled
    -Dmmap=enabled
    -Dpng=enabled
    -Dtests=disabled
    -Dzlib=system
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA} -C <BINARY_DIR> install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(freetype2)
force_meson_configure(freetype2)
