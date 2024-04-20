ExternalProject_Add(
  flac
  DEPENDS ogg
  GIT_REPOSITORY https://github.com/xiph/flac.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR>
    ${cmake_conf_args}
    -DBUILD_CXXLIBS=ON
    -DBUILD_DOCS=OFF
    -DBUILD_EXAMPLES=OFF
    -DBUILD_PROGRAMS=OFF
    -DBUILD_TESTING=OFF
    -DBUILD_UTILS=OFF
    -DENABLE_64_BIT_WORDS=OFF
    -DENABLE_WERROR=OFF
    -DINSTALL_CMAKE_CONFIG_MODULE=ON
    -DINSTALL_MANPAGES=OFF
    -DINSTALL_PKGCONFIG_MODULES=ON
    -DWITH_ASM=ON
    -DWITH_AVX=ON
    -DWITH_FORTIFY_SOURCE=ON
    -DWITH_OGG=ON
    -DWITH_STACK_PROTECTOR=ON
    -DWITH_XMMS=OFF
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA} -C <BINARY_DIR> install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(flac)
