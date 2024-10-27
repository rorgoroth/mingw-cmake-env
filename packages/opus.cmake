ExternalProject_Add(
  opus
  URL https://downloads.xiph.org/releases/opus/opus-1.5.2.tar.gz
  URL_HASH MD5=c40b3a1fbdbb9a7aa178600b88200c76
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} meson setup --reconfigure <BINARY_DIR> <SOURCE_DIR>
    ${meson_conf_args}
    -Ddeep-plc=enabled
    -Ddocs=disabled
    -Ddred=enabled
    -Dextra-programs=disabled
    -Dosce=enabled
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA} -C <BINARY_DIR> install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_meson_configure(opus)
