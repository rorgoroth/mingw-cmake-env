ExternalProject_Add(
  fontconfig
  DEPENDS bzip2
          expat
          freetype2
          libiconv
          zlib
  GIT_REPOSITORY https://github.com/zhongflyTeam/fontconfig.git
  GIT_REMOTE_NAME origin
  GIT_TAG main
  UPDATE_COMMAND ""
  GIT_SHALLOW 1
  PATCH_COMMAND ${EXEC} git am -3 ${CMAKE_CURRENT_SOURCE_DIR}/fontconfig-*.patch
  CONFIGURE_COMMAND
    ${EXEC} meson setup --reconfigure <BINARY_DIR> <SOURCE_DIR>
    ${meson_conf_args}
    -Dcache-build=disabled
    -Ddoc=disabled
    -Dtools=disabled
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA} -C <BINARY_DIR> install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

ExternalProject_Add_Step(
  fontconfig rm-dll
  DEPENDEES install
  COMMAND sh -c "rm ${MINGW_INSTALL_PREFIX}/lib/libfontconfig.dll.a >/dev/null 2>&1 || true"
  COMMAND sh -c "rm ${MINGW_INSTALL_PREFIX}/bin/libfontconfig-1.dll >/dev/null 2>&1 || true")

force_rebuild_git(fontconfig)
force_meson_configure(fontconfig)
