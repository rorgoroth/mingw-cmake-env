ExternalProject_Add(curl
  DEPENDS brotli
          zlib
          zstd
  URL https://github.com/curl/curl/releases/download/curl-8_8_0/curl-8.8.0.tar.bz2
  URL_HASH MD5=d5265a351fdfb12ec840a2a0ba1ce9ff
  DOWNLOAD_EXTRACT_TIMESTAMP 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR>
    ${cmake_conf_args}
    BUILD_CURL_EXE=ON
    BUILD_EXAMPLES=OFF
    BUILD_LIBCURL_DOCS=OFF
    BUILD_MISC_DOCS=OFF
    BUILD_STATIC_CURL=ON
    BUILD_STATIC_LIBS=ON
    BUILD_TESTING=OFF
    CURL_BROTLI=ON
    CURL_CA_FALLBACK=OFF
    CURL_DISABLE_INSTALL=OFF
    CURL_DISABLE_OPENSSL_AUTO_LOAD=OFF
    CURL_ENABLE_SSL=ON
    CURL_LTO=ON
    CURL_STATIC_CRT=ON
    CURL_TARGET_WINDOWS_VERSION=0x0A00
    CURL_USE_BEARSSL=OFF
    CURL_USE_GNUTLS=OFF
    CURL_USE_MBEDTLS=OFF
    CURL_USE_OPENSSL=OFF
    CURL_USE_SCHANNEL=ON
    CURL_USE_WOLFSSL=OFF
    CURL_WERROR=OFF
    CURL_WINDOWS_SSPI=ON
    CURL_ZLIB=ON
    CURL_ZSTD=ON
    ENABLE_ARES=OFF
    ENABLE_CURLDEBUG=OFF
    ENABLE_CURL_MANUAL=OFF
    ENABLE_DEBUG=OFF
    ENABLE_THREADED_RESOLVER=ON
    ENABLE_UNICODE=ON
    ENABLE_UNIX_SOCKETS=ON
    ENABLE_WEBSOCKETS=OFF
    PICKY_COMPILER=ON
    USE_ECH=OFF
    USE_HTTPSRR=OFF
    USE_LIBIDN2=ON
    USE_LIBRTMP=OFF
    USE_MSH3=OFF
    USE_NGHTTP2=OFF
    USE_NGTCP2=OFF
    USE_OPENSSL_QUIC=OFF
    USE_QUICHE=OFF
    USE_WIN32_IDN=OFF
    USE_WIN32_LDAP=ON
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA} -C <BINARY_DIR> install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

