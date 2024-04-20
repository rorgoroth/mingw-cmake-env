ExternalProject_Add(
    directx-headers
  GIT_REPOSITORY https://github.com/microsoft/DirectX-Headers.git
  GIT_SHALLOW 1
  GIT_REMOTE_NAME origin
  GIT_TAG main
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} meson <BINARY_DIR> <SOURCE_DIR>
    ${meson_conf_args}
    --optimization=2
    -Dbuild-test=false
  BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
  INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(directx-headers)
force_meson_configure(directx-headers)
