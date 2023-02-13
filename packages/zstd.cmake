ExternalProject_Add(
  zstd
  DEPENDS zlib
  URL https://github.com/facebook/zstd/releases/download/v1.5.4/zstd-1.5.4.tar.gz
  URL_HASH MD5=2352b1f9ccc7446641046bb3d440c3ed
  CONFIGURE_COMMAND
    ${EXEC} meson setup <BINARY_DIR> <SOURCE_DIR>/build/meson
    --prefix=${MINGW_INSTALL_PREFIX}
    --libdir=${MINGW_INSTALL_PREFIX}/lib
    --cross-file=${MESON_CROSS}
    --buildtype=release
    --default-library=static
    --prefer-static
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
