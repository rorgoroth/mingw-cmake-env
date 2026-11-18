ExternalProject_Add(
  fontconfig
  DEPENDS expat
          freetype2
          libiconv
          zlib
  URL https://gitlab.freedesktop.org/api/v4/projects/890/packages/generic/fontconfig/2.18.4/fontconfig-2.18.4.tar.xz
  URL_HASH SHA256=95013637eff5f81d4871dd16cd098c273264c16d0f9f0b27cc43b81b2794bee3
  PATCH_COMMAND ${EXEC} patch -p1 < ${CMAKE_CURRENT_SOURCE_DIR}/fontconfig-0001.patch
  CONFIGURE_COMMAND
    ${EXEC} meson setup --reconfigure <BINARY_DIR> <SOURCE_DIR>
    ${meson_conf_args}
    -Dcache-build=disabled
    -Ddoc-html=disabled
    -Ddoc-man=disabled
    -Ddoc-pdf=disabled
    -Ddoc-txt=disabled
    -Ddoc=disabled
    -Dfontations=disabled
    -Diconv=enabled
    -Dtests=disabled
    -Dtools=disabled
    -Dxml-backend=expat
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

force_meson_configure(fontconfig)
