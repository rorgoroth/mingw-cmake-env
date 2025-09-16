ExternalProject_Add(
  harfbuzz
  DEPENDS freetype2
          libpng
  URL https://github.com/harfbuzz/harfbuzz/archive/refs/tags/11.5.0.tar.gz
  URL_HASH MD5=f0b80f845227354a2f5cca408239d7ae
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
