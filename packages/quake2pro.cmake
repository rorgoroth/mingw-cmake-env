ExternalProject_Add(
  quake2pro
  DEPENDS curl
          libpng
          libpng
          libsdl2
          openal
          libjpeg
  GIT_REPOSITORY https://github.com/skullernet/q2pro.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  PATCH_COMMAND ${EXEC} git am -3 ${CMAKE_CURRENT_SOURCE_DIR}/quake2pro-*.patch
  CONFIGURE_COMMAND
    ${EXEC} meson setup --reconfigure <BINARY_DIR> <SOURCE_DIR>
    ${meson_conf_args}
    --force-fallback-for=ffmpeg
    -Db_ndebug=true
    -Dlibcurl=enabled
    -Dlibjpeg=enabled
    -Dlibpng=enabled
    -Dopenal=enabled
    -Dsdl2=enabled
    -Dtga=true
    -Dzlib=enabled
    -Dwindows-egl=false
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
    <BINARY_DIR>/gamex86_64.dll
    ${CMAKE_CURRENT_BINARY_DIR}/quake2pro-package/gamex86_64.dll
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <BINARY_DIR>/q2pro.exe
    ${CMAKE_CURRENT_BINARY_DIR}/quake2pro-package/q2pro.exe
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <BINARY_DIR>/q2proded.exe
    ${CMAKE_CURRENT_BINARY_DIR}/quake2pro-package/q2proded.exe)

force_rebuild_git(quake2pro)
force_meson_configure(quake2pro)
