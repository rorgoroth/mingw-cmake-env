if(${TARGET_CPU} MATCHES "x86_64")
    set(arch "x86-64-v3")
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
  URL https://github.com/gcc-mirror/gcc/archive/d3e427f684b0cd7cedbe7b93a06f455e562c5901.tar.gz
  URL_HASH MD5=988f9ca1265efda167f5c8030d5c0d10
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
  BUILD_COMMAND make -j${MAKEJOBS} all-gcc
  INSTALL_COMMAND make install-strip-gcc
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)
