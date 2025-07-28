ExternalProject_Add(
  harfbuzz
  DEPENDS freetype2
          libpng
  URL https://github.com/harfbuzz/harfbuzz/releases/download/11.3.3/harfbuzz-11.3.3.tar.xz
  URL_HASH MD5=d46b8dfcb8a6da5e7ca240a811998ef4
  DOWNLOAD_EXTRACT_TIMESTAMP 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} meson setup --reconfigure <BINARY_DIR> <SOURCE_DIR>
    ${meson_conf_args}
    -Dbenchmark=disabled
    -Ddocs=disabled
    -Dglib=disabled
    -Dgobject=disabled
    -Dicu=disabled
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA} -C <BINARY_DIR> install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

  force_meson_configure(harfbuzz)
