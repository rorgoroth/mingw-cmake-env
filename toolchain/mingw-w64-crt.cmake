if(${TARGET_CPU} MATCHES "x86_64")
    set(disable_lib "--disable-lib32")
else()
    set(disable_lib "--disable-lib64")
endif()

ExternalProject_Add(
  mingw-w64-crt
  EXCLUDE_FROM_ALL 1
  DEPENDS mingw-w64 gcc-base
  PREFIX mingw-w64-prefix
  SOURCE_DIR mingw-w64-prefix/src
  CONFIGURE_COMMAND
    ${EXEC} <SOURCE_DIR>/mingw-w64/mingw-w64-crt/configure
    --host=${TARGET_ARCH}
    --prefix=${MINGW_INSTALL_PREFIX}
    --with-sysroot=${CMAKE_INSTALL_PREFIX}
    --with-default-msvcrt=ucrt
    --enable-wildcard
    ${disable_lib}
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install-strip
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)
