find_program(PKGCONFIG NAMES pkg-config)

ExternalProject_Add(
  llvm
  EXCLUDE_FROM_ALL 1
  URL https://github.com/rorgoroth/llvm-mingw/releases/download/19.1.3/19.1.3.tar.zst
  URL_HASH MD5=cebf30dee2c916c0b023857135a9b6e9
  DOWNLOAD_EXTRACT_TIMESTAMP 1
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND
    COMMAND
      ${CMAKE_COMMAND} -E make_directory
      ${CMAKE_INSTALL_PREFIX}
    COMMAND
      ${CMAKE_COMMAND} -E make_directory
      ${CMAKE_INSTALL_PREFIX}/bin
    COMMAND
      ${CMAKE_COMMAND} -E copy_directory
      <SOURCE_DIR>/bin ${CMAKE_INSTALL_PREFIX}/bin
    COMMAND
      ${CMAKE_COMMAND} -E make_directory
      ${CMAKE_INSTALL_PREFIX}/generic-w64-mingw32
    COMMAND
      ${CMAKE_COMMAND} -E copy_directory
      <SOURCE_DIR>/generic-w64-mingw32
      ${CMAKE_INSTALL_PREFIX}/generic-w64-mingw32
    COMMAND
      ${CMAKE_COMMAND} -E make_directory
      ${CMAKE_INSTALL_PREFIX}/include
    COMMAND
      ${CMAKE_COMMAND} -E copy_directory
      <SOURCE_DIR>/include
      ${CMAKE_INSTALL_PREFIX}/include
    COMMAND
      ${CMAKE_COMMAND} -E make_directory
      ${CMAKE_INSTALL_PREFIX}/lib
    COMMAND
      ${CMAKE_COMMAND} -E copy_directory
      <SOURCE_DIR>/lib
      ${CMAKE_INSTALL_PREFIX}/lib
    COMMAND
      ${CMAKE_COMMAND} -E make_directory
      ${CMAKE_INSTALL_PREFIX}/share
    COMMAND
      ${CMAKE_COMMAND} -E copy_directory
      <SOURCE_DIR>/share
      ${CMAKE_INSTALL_PREFIX}/share
    COMMAND
      ${CMAKE_COMMAND} -E make_directory
      ${CMAKE_INSTALL_PREFIX}/x86_64-w64-mingw32
    COMMAND
      ${CMAKE_COMMAND} -E copy_directory
      <SOURCE_DIR>/x86_64-w64-mingw32
      ${CMAKE_INSTALL_PREFIX}/x86_64-w64-mingw32
    COMMAND
      ${CMAKE_COMMAND} -E create_symlink
      ${CMAKE_INSTALL_PREFIX}/x86_64-w64-mingw32
      ${CMAKE_INSTALL_PREFIX}/mingw
    COMMAND
      ${CMAKE_COMMAND} -E create_symlink
      ${PKGCONFIG}
      ${CMAKE_INSTALL_PREFIX}/bin/x86_64-w64-mingw32-pkg-config
    COMMAND
      ${CMAKE_COMMAND} -E create_symlink
      ${CMAKE_INSTALL_PREFIX}/x86_64-w64-mingw32/lib
      ${CMAKE_INSTALL_PREFIX}/x86_64-w64-mingw32/lib64
  LOG_DOWNLOAD 1
  LOG_UPDATE 1)
