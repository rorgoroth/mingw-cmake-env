ExternalProject_Add(
  rustup
  EXCLUDE_FROM_ALL 1
  DOWNLOAD_COMMAND ""
  UPDATE_COMMAND ""
  SOURCE_DIR rustup-prefix/src
  CONFIGURE_COMMAND ${EXEC}
    curl -sSf https://sh.rustup.rs |
    sh -s -- -y --default-toolchain nightly --target x86_64-pc-windows-gnullvm --no-modify-path --profile minimal
  BUILD_COMMAND ${EXEC} rustup update
  INSTALL_COMMAND ""
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)
