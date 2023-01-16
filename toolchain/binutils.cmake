ExternalProject_Add(
  binutils
  EXCLUDE_FROM_ALL 1
  URL https://ftp.gnu.org/gnu/binutils/binutils-2.40.tar.xz
  URL_HASH MD5=007b59bd908a737c06e5a8d3d2c737eb
  CONFIGURE_COMMAND
    <SOURCE_DIR>/configure
    --target=${TARGET_ARCH}
    --prefix=${CMAKE_INSTALL_PREFIX}
    --with-sysroot=${CMAKE_INSTALL_PREFIX}
    --disable-multilib
    --disable-nls
    --disable-shared
    --disable-win32-registry
    --without-included-gettext
    --enable-lto
    --enable-plugins
    --enable-threads
  BUILD_COMMAND make -j${MAKEJOBS}
  INSTALL_COMMAND make install-strip
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

find_program(PKGCONFIG NAMES pkg-config)

ExternalProject_Add_Step(
  binutils basedirs
  DEPENDEES download
  COMMAND
    ${CMAKE_COMMAND} -E make_directory
    ${CMAKE_INSTALL_PREFIX}
  COMMAND
    ${CMAKE_COMMAND} -E make_directory
    ${CMAKE_INSTALL_PREFIX}/bin
  COMMAND
    ${CMAKE_COMMAND} -E create_symlink
    ${PKGCONFIG}
    ${CMAKE_INSTALL_PREFIX}/bin/${TARGET_ARCH}-pkg-config
  COMMAND
    ${CMAKE_COMMAND} -E make_directory
    ${CMAKE_INSTALL_PREFIX}/${TARGET_ARCH}
  COMMAND
    ${CMAKE_COMMAND} -E create_symlink
    ${CMAKE_INSTALL_PREFIX}/${TARGET_ARCH}
    ${CMAKE_INSTALL_PREFIX}/mingw
  COMMAND
    ${CMAKE_COMMAND} -E make_directory
    ${CMAKE_INSTALL_PREFIX}/${TARGET_ARCH}/lib
  COMMAND
    ${CMAKE_COMMAND} -E create_symlink
    ${CMAKE_INSTALL_PREFIX}/${TARGET_ARCH}/lib
    ${CMAKE_INSTALL_PREFIX}/${TARGET_ARCH}/lib64
  COMMENT "Setting up target directories and symlinks")
