ExternalProject_Add(
  zstd
  DEPENDS zlib
  URL https://github.com/facebook/zstd/releases/download/v1.6.0/zstd-1.6.0.tar.gz
  URL_HASH SHA256=2ba599ae2a257976278e7e71e998433a387bfd18aa7b78678229fd5d84f5e9b8
  DOWNLOAD_EXTRACT_TIMESTAMP 1
  CONFIGURE_COMMAND
    ${EXEC} meson setup --reconfigure <BINARY_DIR> <SOURCE_DIR>/build/meson
    ${meson_conf_args}
    -Dlzma=disabled
    -Dlz4=disabled
    -Dzlib=enabled
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA} install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_meson_configure(zstd)
