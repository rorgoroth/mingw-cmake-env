if(${TARGET_CPU} MATCHES "x86_64")
    set(arch "${GCC_ARCH}")
else()
    set(arch "i686")
endif()

ExternalProject_Add(
  gcc-base
  EXCLUDE_FROM_ALL 1
  DEPENDS mingw-w64-headers
  PREFIX gcc-prefix
  STAMP_DIR gcc-prefix/src/gcc-stamp
  SOURCE_DIR gcc-prefix/src/gcc
  BINARY_DIR gcc-prefix/src/gcc-build
  URL https://github.com/gcc-mirror/gcc/archive/d495ea2b232f3eb50155d7c7362c09a744766746.tar.gz
  URL_HASH MD5=6e3f3df103661b5745fd6b8ab0bfd89b
  PATCH_COMMAND
    patch -p1 <
    ${CMAKE_CURRENT_SOURCE_DIR}/gcc-0001-libcc1-include-pthread.patch
  COMMAND
    patch -p1 <
    ${CMAKE_CURRENT_SOURCE_DIR}/gcc-0002-posix-memalign.patch
  COMMAND
    patch -p1 <
    ${CMAKE_CURRENT_SOURCE_DIR}/gcc-0003-vmov.patch
  CONFIGURE_COMMAND
    <SOURCE_DIR>/configure
    --target=${TARGET_ARCH}
    --prefix=${CMAKE_INSTALL_PREFIX}
    --libdir=${CMAKE_INSTALL_PREFIX}/lib
    --with-sysroot=${CMAKE_INSTALL_PREFIX}
    --disable-multilib
    --disable-nls
    --disable-shared
    --disable-sjlj-exceptions
    --disable-win32-registry
    --enable-checking=release
    --enable-checking=release
    --enable-default-pie
    --enable-default-ssp
    --enable-languages=c,c++
    --enable-libssp
    --enable-lto
    --enable-threads=posix
    --with-arch=${arch}
    --without-included-gettext
  BUILD_COMMAND make -j${MAKEJOBS} all-gcc
  INSTALL_COMMAND make install-strip-gcc
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)
