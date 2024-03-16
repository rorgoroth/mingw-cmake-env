if(CYGWIN OR MSYS)
    set(LUAJIT_HOST_GCC ${TARGET_ARCH}-gcc)
else()
    set(LUAJIT_HOST_GCC gcc)
endif()

if(${TARGET_CPU} MATCHES "i686")
    set(LUAJIT_GCC_ARGS "-m32")
    set(DISABLE_JIT "-DLUAJIT_DISABLE_JIT")
else()
    set(LUAJIT_GCC_ARGS "-m64")
endif()

set(EXPORT
    "CROSS=${TARGET_ARCH}-
    TARGET_SYS=Windows
    BUILDMODE=static
    FILE_T=luajit.exe
    CFLAGS='-D_WIN32_WINNT=0x0A00 -DUNICODE'
    XCFLAGS='-DLUAJIT_ENABLE_LUA52COMPAT ${DISABLE_JIT}'
    PREFIX=${MINGW_INSTALL_PREFIX} Q="
)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/luajit.pc.in ${CMAKE_CURRENT_BINARY_DIR}/luajit.pc @ONLY)

ExternalProject_Add(
  luajit
  DEPENDS libiconv
  GIT_REPOSITORY https://github.com/openresty/luajit2.git
  GIT_REMOTE_NAME origin
  GIT_TAG v2.1-agentzh
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ${MAKE} -C <SOURCE_DIR>/src
                "HOST_CC='${LUAJIT_HOST_GCC} ${LUAJIT_GCC_ARGS}'"
                ${EXPORT} amalg
INSTALL_COMMAND ${MAKE}
                "HOST_CC='${LUAJIT_HOST_GCC} ${LUAJIT_GCC_ARGS}'"
                ${EXPORT} install
BUILD_IN_SOURCE 1
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

ExternalProject_Add_Step(
  luajit install-pc
  DEPENDEES install
  COMMAND
    ${CMAKE_COMMAND} -E copy
    ${CMAKE_CURRENT_BINARY_DIR}/luajit.pc
    ${MINGW_INSTALL_PREFIX}/lib/pkgconfig/luajit.pc)

force_rebuild_git(luajit)
clean_build(luajit install)
