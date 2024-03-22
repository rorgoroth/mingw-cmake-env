ExternalProject_Add(
  freetype2
  DEPENDS brotli
          bzip2
          libpng
          zlib
  GIT_REPOSITORY https://github.com/freetype/freetype.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} meson setup <BINARY_DIR> <SOURCE_DIR>
    --prefix=${MINGW_INSTALL_PREFIX}
    --cross-file=${MESON_CROSS}
    --buildtype=release
    --default-library=static
    -Dbzip2=disabled
    -Dharfbuzz=disabled
    -Dbrotli=enabled
    -Dmmap=enabled
    -Dpng=enabled
    -Dtests=disabled
    -Dzlib=enabled
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA} -C <BINARY_DIR> install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(freetype2)
force_meson_configure(freetype2)
clean_build(freetype2 install)
