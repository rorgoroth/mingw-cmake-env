ExternalProject_Add(
  quake2pro
  DEPENDS curl
          ffmpeg
          libpng
          libpng
          libsdl2
          openal
          libjpeg
  GIT_REPOSITORY https://github.com/skullernet/q2pro.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  PATCH_COMMAND ${EXEC} git am ${CMAKE_CURRENT_SOURCE_DIR}/quake2pro-*.patch
  CONFIGURE_COMMAND
    ${EXEC-NLTO} meson setup <BINARY_DIR> <SOURCE_DIR>
    --prefix=${MINGW_INSTALL_PREFIX}
    --libdir=${MINGW_INSTALL_PREFIX}/lib
    --cross-file=${MESON_CROSS}
    --buildtype=release
    --default-library=static
    --prefer-static
    -Db_ndebug=true
    -Dlibcurl=enabled
    -Dlibjpeg=enabled
    -Dlibpng=enabled
    -Dopenal=enabled
    -Dsdl2=enabled
    -Dtga=true
    -Dzlib=enabled
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ""
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

ExternalProject_Add_Step(
  quake2pro strip-binary
  DEPENDEES build
  COMMAND
    ${EXEC} x86_64-w64-mingw32-strip -s
    <BINARY_DIR>/q2pro.exe
  COMMAND
    ${EXEC} x86_64-w64-mingw32-strip -s
    <BINARY_DIR>/q2proded.exe)

ExternalProject_Add_Step(
  quake2pro copy-binary
  DEPENDEES strip-binary
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <BINARY_DIR>/q2pro.exe
    ${CMAKE_CURRENT_BINARY_DIR}/quake2pro-package/q2pro.exe
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <BINARY_DIR>/q2proded.exe
    ${CMAKE_CURRENT_BINARY_DIR}/quake2pro-package/q2proded.exe)

ExternalProject_Add_Step(
    quake2pro clean
  DEPENDEES copy-binary
  COMMAND sh -c "rm -rf <BINARY_DIR>/* && git -C <SOURCE_DIR> clean -xdf >/dev/null 2>&1 || true"
  COMMENT "Performing clean step for 'quake2pro'")

force_rebuild_git(quake2pro)
force_meson_configure(quake2pro)
