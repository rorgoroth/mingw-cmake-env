ExternalProject_Add(gcc-base
  DEPENDS
    mingw-w64-headers
  PREFIX gcc-prefix
  STAMP_DIR gcc-prefix/src/gcc-stamp
  SOURCE_DIR gcc-prefix/src/gcc
  BINARY_DIR gcc-prefix/src/gcc-build
  URL https://mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-11.3.0/gcc-11.3.0.tar.gz
  URL_HASH MD5=b29cf744540c87262fb82e550aa24b11
  CONFIGURE_COMMAND <SOURCE_DIR>/configure
    --target=${TARGET_ARCH}
    --prefix=${CMAKE_INSTALL_PREFIX}
    --libdir=${CMAKE_INSTALL_PREFIX}/lib
    --with-sysroot=${CMAKE_INSTALL_PREFIX}
    --disable-multilib
    --disable-nls
    --disable-shared
    --disable-win32-registry
    --enable-checking=release
    --enable-default-pie
    --enable-default-ssp
    --enable-languages=c,c++
    --enable-libssp
    --enable-lto
    --enable-seh-exceptions
    --enable-threads=posix
    --with-arch=x86-64-v3
    --without-included-gettext
  BUILD_COMMAND make -j${MAKEJOBS} all-gcc
  INSTALL_COMMAND make install-strip-gcc
  LOG_DOWNLOAD 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)
