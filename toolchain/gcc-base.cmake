if(${TARGET_CPU} MATCHES "x86_64")
    set(arch "x86-64-v3")
    set(exception "--enable-seh-exceptions")
else()
    set(arch "i686")
    set(exception "--enable-dw2-exceptions")
endif()

ExternalProject_Add(
  gcc-base
  EXCLUDE_FROM_ALL 1
  DEPENDS mingw-w64-headers
  PREFIX gcc-prefix
  STAMP_DIR gcc-prefix/src/gcc-stamp
  SOURCE_DIR gcc-prefix/src/gcc
  BINARY_DIR gcc-prefix/src/gcc-build
  URL https://mirrorservice.org/sites/sourceware.org/pub/gcc/snapshots/13-20230129/gcc-13-20230129.tar.xz
  URL_HASH MD5=3de39366a3a91db05553bbdee0b2020b
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
    ${exception}
  BUILD_COMMAND make -j${MAKEJOBS} all-gcc
  INSTALL_COMMAND make install-strip-gcc
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)
