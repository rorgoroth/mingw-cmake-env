ExternalProject_Add(
  rubberband
  DEPENDS libsamplerate
  URL https://github.com/breakfastquay/rubberband/archive/refs/tags/v4.0.0.tar.gz
  URL_HASH SHA256=24300f48a8014b7c863b573a9647e61b1b19b37875e2cdd92005e64c6424d266
  DOWNLOAD_EXTRACT_TIMESTAMP 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} meson setup --reconfigure <BINARY_DIR> <SOURCE_DIR>
    ${meson_conf_args}
    -Dfft=builtin
    -Dresampler=libsamplerate
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA} -C <BINARY_DIR> install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

