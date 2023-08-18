ExternalProject_Add(
  llvm
  EXCLUDE_FROM_ALL 1
  URL https://github.com/rorgoroth/llvm-mingw/releases/download/2023-08-19/llvm-x86_64-w64-mingw32_17.0.0-rc2.tar.xz
  URL_HASH MD5=c401ae48b7044d91abd8f4b293a75ae8
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

find_program(PKGCONFIG NAMES pkg-config)

ExternalProject_Add_Step(
  llvm basedirs
  DEPENDEES download
  COMMAND
    ${CMAKE_COMMAND} -E make_directory
    ${CMAKE_INSTALL_PREFIX}

  COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_INSTALL_PREFIX}/bin
  COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/bin ${CMAKE_INSTALL_PREFIX}/bin
  COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_INSTALL_PREFIX}/generic-w64-mingw32
  COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/generic-w64-mingw32 ${CMAKE_INSTALL_PREFIX}/generic-w64-mingw32
  COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_INSTALL_PREFIX}/include
  COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/include ${CMAKE_INSTALL_PREFIX}/include
  COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_INSTALL_PREFIX}/lib
  COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/lib ${CMAKE_INSTALL_PREFIX}/lib
  COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_INSTALL_PREFIX}/share
  COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/share ${CMAKE_INSTALL_PREFIX}/share
  COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_INSTALL_PREFIX}/x86_64-w64-mingw32
  COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/x86_64-w64-mingw32 ${CMAKE_INSTALL_PREFIX}/x86_64-w64-mingw32

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
  COMMENT "Setting up target directories and symlinks")
