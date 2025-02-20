ExternalProject_Add(
  zstd
  DEPENDS zlib
  URL https://github.com/facebook/zstd/releases/download/v1.5.7/zstd-1.5.7.tar.gz
  URL_HASH MD5=780fc1896922b1bc52a4e90980cdda48
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
