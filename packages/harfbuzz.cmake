ExternalProject_Add(
  harfbuzz
  DEPENDS freetype2
          libpng
  URL https://github.com/harfbuzz/harfbuzz/archive/refs/tags/15.1.0.tar.gz
  URL_HASH SHA256=5c057929413b8664592fea67edea5c2c47b4ffb0bf5f4accb5164bc6acc69d94
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
    -Dtests=disabled
    -Dutilities=disabled
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA} -C <BINARY_DIR> install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

  force_meson_configure(harfbuzz)
