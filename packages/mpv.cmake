ExternalProject_Add(
  mpv
  DEPENDS ffmpeg
          fribidi
          lcms2
          libass
          libiconv
          libjpeg
          libplacebo
          libpng
          luajit
          mujs
          openal
          rubberband
          shaderc
          spirv-cross
          uchardet
          vulkan-loader
  GIT_REPOSITORY https://github.com/mpv-player/mpv.git
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} meson setup <BINARY_DIR> <SOURCE_DIR>
    ${meson_conf_args}
    -Db_lto_mode=thin
    -Db_ndebug=true
    -Dd3d11=enabled
    -Diconv=enabled
    -Djavascript=enabled
    -Djpeg=enabled
    -Dlcms2=enabled
    -Dlua=enabled
    -Dmanpage-build=disabled
    -Dopenal=enabled
    -Drubberband=enabled
    -Dshaderc=enabled
    -Dspirv-cross=enabled
    -Duchardet=enabled
    -Dvulkan=enabled
    -Dzimg=enabled
    -Dzlib=enabled
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ""
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

ExternalProject_Add_Step(
  mpv strip-binary
  DEPENDEES build
  COMMAND
    ${EXEC} x86_64-w64-mingw32-strip -s
    <BINARY_DIR>/mpv.exe
  COMMAND
    ${EXEC} x86_64-w64-mingw32-strip -s
    <BINARY_DIR>/mpv.com)

ExternalProject_Add_Step(
  mpv copy-binary
  DEPENDEES strip-binary
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <BINARY_DIR>/mpv.exe
    ${CMAKE_CURRENT_BINARY_DIR}/mpv-package/mpv.exe
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <BINARY_DIR>/mpv.com
    ${CMAKE_CURRENT_BINARY_DIR}/mpv-package/mpv.com
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <SOURCE_DIR>/etc/powershell-completion.ps1
    ${CMAKE_CURRENT_BINARY_DIR}/mpv-package/powershell-completion.ps1)

force_rebuild_git(mpv)
force_meson_configure(mpv)
