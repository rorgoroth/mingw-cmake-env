ExternalProject_Add(curl
  DEPENDS
  URL https://github.com/curl/curl/releases/download/curl-7_80_0/curl-7.80.0.tar.xz
  URL_HASH MD5=cf9f8553762150ef0ebcd5ee412737f5
  PATCH_COMMAND ${EXEC} patch -p1 < ${CMAKE_CURRENT_SOURCE_DIR}/curl-001.patch
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND ${EXEC} <SOURCE_DIR>/configure
    --host=${TARGET_ARCH}
    --prefix=${MINGW_INSTALL_PREFIX}
    --disable-shared
    --disable-alt-svc
    --disable-ares
    --disable-cookies
    --disable-crypto-auth
    --disable-curldebug
    --disable-dateparse
    --disable-debug
    --disable-dependency-tracking
    --disable-dict
    --disable-dnsshuffle
    --disable-doh
    --disable-ech
    --disable-gopher
    --disable-hsts
    --disable-http-auth
    --disable-imap
    --disable-ldap
    --disable-ldaps
    --disable-manual
    --disable-mime
    --disable-mqtt
    --disable-netrc
    --disable-ntlm
    --disable-pop3
    --disable-progress-meter
    --disable-proxy
    --disable-rtsp
    --disable-shared
    --disable-smb
    --disable-smtp
    --disable-socketpair
    --disable-sspi
    --disable-telnet
    --disable-tftp
    --disable-unix-sockets
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
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)
