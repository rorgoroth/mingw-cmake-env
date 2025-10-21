find_program(PKGCONFIG NAMES pkg-config)

ExternalProject_Add(
  llvm
  EXCLUDE_FROM_ALL 1
  URL https://github.com/rorgoroth/llvm-mingw/releases/download/21.1.4/21.1.4.tar.zst
  URL_HASH SHA256=a625662abf462cf37a0a73d382a9f2648f65eb4cc3652424122a83edb2888628
  DOWNLOAD_EXTRACT_TIMESTAMP 1
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND
    COMMAND sh -c "mkdir -p ${CMAKE_INSTALL_PREFIX}"
    COMMAND sh -c "cp -ar <SOURCE_DIR>/bin ${CMAKE_INSTALL_PREFIX}/"
    COMMAND sh -c "cp -ar <SOURCE_DIR>/generic-w64-mingw32 ${CMAKE_INSTALL_PREFIX}/"
    COMMAND sh -c "cp -ar <SOURCE_DIR>/include ${CMAKE_INSTALL_PREFIX}/"
    COMMAND sh -c "cp -ar <SOURCE_DIR>/lib ${CMAKE_INSTALL_PREFIX}/"
    COMMAND sh -c "cp -ar <SOURCE_DIR>/share ${CMAKE_INSTALL_PREFIX}/"
    COMMAND sh -c "cp -ar <SOURCE_DIR>/x86_64-w64-mingw32 ${CMAKE_INSTALL_PREFIX}/"
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
  LOG_INSTALL 1
  LOG_UPDATE 1)
