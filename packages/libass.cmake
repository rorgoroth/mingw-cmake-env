ExternalProject_Add(
  libass
  DEPENDS fontconfig
          freetype2
          fribidi
          harfbuzz
          libiconv
          libunibreak
  GIT_REPOSITORY https://github.com/libass/libass.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} meson setup --reconfigure <BINARY_DIR> <SOURCE_DIR>
    ${meson_conf_args}
    -Dasm=enabled
    -Ddirectwrite=enabled
    -Dfontconfig=enabled
    -Dlibunibreak=enabled
    -Dtest=disabled
    -Dcompare=disabled
    -Dprofile=disabled
    -Dfuzz=disabled
    -Dcheckasm=disabled
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA} -C <BINARY_DIR> install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(libass)
force_meson_configure(libass)
