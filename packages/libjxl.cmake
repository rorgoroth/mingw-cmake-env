ExternalProject_Add(
  libjxl
  DEPENDS brotli
          highway
          lcms2
          libjpeg
          libpng
          zlib
  URL https://github.com/libjxl/libjxl/archive/refs/tags/v0.11.1.tar.gz
  URL_HASH MD5=8f26fc954c2d9cb377544a5f029182ef
  DOWNLOAD_EXTRACT_TIMESTAMP 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR>
    ${cmake_conf_args}
    -DJPEGXL_BUNDLE_LIBPNG=OFF
    -DJPEGXL_ENABLE_AVX512_SPR=OFF
    -DJPEGXL_ENABLE_AVX512_ZEN4=OFF
    -DJPEGXL_ENABLE_AVX512=OFF
    -DJPEGXL_ENABLE_BENCHMARK=OFF
    -DJPEGXL_ENABLE_BOXES=ON
    -DJPEGXL_ENABLE_COVERAGE=OFF
    -DJPEGXL_ENABLE_DEVTOOLS=OFF
    -DJPEGXL_ENABLE_DOXYGEN=OFF
    -DJPEGXL_ENABLE_EXAMPLES=OFF
    -DJPEGXL_ENABLE_FUZZERS=OFF
    -DJPEGXL_ENABLE_JNI=OFF
    -DJPEGXL_ENABLE_JPEGLI_LIBJPEG=OFF
    -DJPEGXL_ENABLE_JPEGLI=OFF
    -DJPEGXL_ENABLE_MANPAGES=OFF
    -DJPEGXL_ENABLE_OPENEXR=OFF
    -DJPEGXL_ENABLE_PLUGINS=OFF
    -DJPEGXL_ENABLE_SIZELESS_VECTORS=OFF
    -DJPEGXL_ENABLE_SJPEG=OFF
    -DJPEGXL_ENABLE_SKCMS=OFF
    -DJPEGXL_ENABLE_TCMALLOC=OFF
    -DJPEGXL_ENABLE_TOOLS=OFF
    -DJPEGXL_ENABLE_TRANSCODE_JPEG=ON
    -DJPEGXL_ENABLE_VIEWERS=OFF
    -DJPEGXL_ENABLE_WASM_TRHEADS=ON
    -DJPEGXL_FORCE_NEON=OFF
    -DJPEGXL_FORCE_SYSTEM_BROTLI=ON
    -DJPEGXL_FORCE_SYSTEM_GTEST=ON
    -DJPEGXL_FORCE_SYSTEM_HWY=ON
    -DJPEGXL_FORCE_SYSTEM_LCMS2=ON
    -DJPEGXL_INSTALL_JPEGLI_LIBJPEG=OFF
    -DJPEGXL_STATIC=ON
    -DJPEGXL_TEST_TOOLS=OFF
    -DJPEGXL_WARNINGS_AS_ERRORS=OFF
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA} -C <BINARY_DIR> install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

