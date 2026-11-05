ExternalProject_Add(
  openssl
  URL https://github.com/openssl/openssl/releases/download/openssl-4.1.0/openssl-4.1.0.tar.gz
  URL_HASH SHA256=50c17baf54cb008f6ce42d50deb4b28050a1aad711636cabd4b241c7e90cc2fd
  DOWNLOAD_EXTRACT_TIMESTAMP 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${CMAKE_COMMAND} -E make_directory <BINARY_DIR>/apps/include
  COMMAND
    ${EXEC} <SOURCE_DIR>/Configure mingw64
    AR=x86_64-w64-mingw32-ar
    RANLIB=x86_64-w64-mingw32-ranlib
    RC=x86_64-w64-mingw32-windres
    --prefix=${MINGW_INSTALL_PREFIX}
    --libdir=lib
    --release
    no-apps
    no-autoload-config
    no-docs
    no-legacy
    no-module
    no-shared
    no-tests
    threads
  BUILD_COMMAND ${MAKE} build_sw
  INSTALL_COMMAND ${MAKE} install_sw
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)
