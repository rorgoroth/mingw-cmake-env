if(${TARGET_CPU} MATCHES "x86_64")
    set(libvpx_target "x86_64-win64-gcc")
else()
    set(libvpx_target "x86-win32-gcc")
endif()

ExternalProject_Add(
  libvpx
  GIT_REPOSITORY https://chromium.googlesource.com/webm/libvpx.git
  GIT_SHALLOW 1
  GIT_REMOTE_NAME origin
  GIT_TAG main
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} CROSS=${TARGET_ARCH}- <SOURCE_DIR>/configure
    --target=${libvpx_target}
    --prefix=${MINGW_INSTALL_PREFIX}
    --as=yasm
    --disable-decode-perf-tests
    --disable-encode-perf-tests
    --disable-docs
    --disable-examples
    --disable-shared
    --disable-tools
    --disable-unit-tests
    --enable-debug
    --enable-postproc
    --enable-runtime-cpu-detect
    --enable-static
    --enable-vp8
    --enable-vp9
    --enable-vp9-postproc
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(libvpx)
