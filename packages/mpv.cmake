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
          rubberband
          shaderc
          spirv-cross
          uchardet
          vulkan-loader
  GIT_REPOSITORY https://github.com/mpv-player/mpv.git
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} meson <BINARY_DIR> <SOURCE_DIR>
    --prefix=${MINGW_INSTALL_PREFIX}
    --libdir=${MINGW_INSTALL_PREFIX}/lib
    --cross-file=${MESON_CROSS}
    --buildtype=plain
    --default-library=static
    --prefer-static
    -Db_ndebug=true
    -Dd3d11=enabled
    -Diconv=enabled
    -Djpeg=enabled
    -Dlcms2=enabled
    -Dlibplacebo=enabled
    -Dlua=enabled
    -Dmanpage-build=disabled
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
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

ExternalProject_Add_Step(
  mpv strip-binary
  DEPENDEES build
  COMMAND
    ${EXEC} ${TARGET_ARCH}-strip -s
    <BINARY_DIR>/mpv.exe
  COMMAND
    ${EXEC} ${TARGET_ARCH}-strip -s
    <BINARY_DIR>/generated/mpv.com)

ExternalProject_Add_Step(
  mpv copy-binary
  DEPENDEES strip-binary
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <BINARY_DIR>/mpv.exe
    ${CMAKE_CURRENT_BINARY_DIR}/mpv-package/mpv.exe
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <BINARY_DIR>/generated/mpv.com
    ${CMAKE_CURRENT_BINARY_DIR}/mpv-package/mpv.com)

force_rebuild_git(mpv)
force_meson_configure(mpv)
