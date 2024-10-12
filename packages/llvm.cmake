find_program(PKGCONFIG NAMES pkg-config)

ExternalProject_Add(
  llvm
  GIT_REPOSITORY https://github.com/rorgoroth/llvm-mingw.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND ""
  BUILD_COMMAND
	COMMAND
      bash -c "./build-all.sh --host-clang --disable-dylib --disable-lldb --disable-lldb-mi --disable-clang-tools-extra --with-default-win32-winnt=0x0A00 --with-default-msvcrt=ucrt --disable-cfguard ${CMAKE_INSTALL_PREFIX}"
  BUILD_IN_SOURCE 1
  INSTALL_COMMAND
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
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(llvm)
