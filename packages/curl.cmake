ExternalProject_Add(curl
  DEPENDS gcc
  URL https://github.com/curl/curl/releases/download/curl-7_82_0/curl-7.82.0.tar.bz2
  URL_HASH MD5=877ca5b5ea2199d37ba357412e7d74be
  PATCH_COMMAND ${EXEC} patch -p1 < ${CMAKE_CURRENT_SOURCE_DIR}/curl-001.patch
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND ${EXEC} <SOURCE_DIR>/configure
    --host=${TARGET_ARCH}
    --prefix=${MINGW_INSTALL_PREFIX}
    --disable-curldebug
    --disable-debug
    --disable-ldap
    --disable-ldaps
    --disable-manual
    --disable-shared
    --disable-verbose
    --disable-warnings
    --disable-werror
    --enable-file
    --enable-ftp
    --enable-http
    --enable-ipv6
    --enable-libcurl-option
    --enable-optimize
    --enable-pthreads
    --enable-silent-rules
    --enable-static
    --enable-symbol-hiding
    --enable-threaded-resolver
    --with-schannel
    --without-zlib
  BUILD_COMMAND ${EXEC} ${MAKE}
  INSTALL_COMMAND ${EXEC} ${MAKE} install
  LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)
