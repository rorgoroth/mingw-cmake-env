ExternalProject_Add(
  fontconfig
  DEPENDS bzip2
          expat
          freetype2
          libiconv
          zlib
  GIT_REPOSITORY https://github.com/freedesktop/fontconfig.git
  GIT_REMOTE_NAME origin
  GIT_TAG main
  UPDATE_COMMAND ""
  GIT_SHALLOW 1
  PATCH_COMMAND ${EXEC} git am ${CMAKE_CURRENT_SOURCE_DIR}/fontconfig-*.patch
  CONFIGURE_COMMAND
    ${EXEC} meson <BINARY_DIR> <SOURCE_DIR>
    --prefix=${MINGW_INSTALL_PREFIX}
    --libdir=${MINGW_INSTALL_PREFIX}/lib
    --cross-file=${MESON_CROSS}
    --buildtype=release
    --default-library=static
    -Dcache-build=disabled
    -Ddoc=disabled
    -Dtests=disabled
    -Dtools=disabled
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA} -C <BINARY_DIR>
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(fontconfig)
force_meson_configure(fontconfig)
