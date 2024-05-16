function(force_rebuild_git _name)
  get_property(
    git_tag
    TARGET ${_name}
    PROPERTY _EP_GIT_TAG)
  get_property(
    git_remote_name
    TARGET ${_name}
    PROPERTY _EP_GIT_REMOTE_NAME)

  if("${git_remote_name}" STREQUAL "" AND NOT "${git_tag}" STREQUAL "")
    # GIT_REMOTE_NAME is not set when commit hash is specified
    set(pull "")
  else()
    set(git_tag "@{u}")
    set(pull COMMAND git pull)
  endif()

  ExternalProject_Add_Step(
    ${_name} force-update
    INDEPENDENT 1
    DEPENDEES download update
    DEPENDERS patch build install
    COMMAND sh -c "git am --abort 2> /dev/null || true"
    COMMAND git reset --hard ${git_tag} ${pull}
    WORKING_DIRECTORY <SOURCE_DIR>
    LOG 1)
endfunction()

function(force_git_patch _name)
  ExternalProject_Add_Step(
    ${_name} force-git-patch
    DEPENDEES force-update patch
    DEPENDERS configure
    COMMAND ${EXEC} git am -3 ${CMAKE_CURRENT_SOURCE_DIR}/${_name}-*.patch
    WORKING_DIRECTORY <SOURCE_DIR>
    LOG 1)
endfunction()

function(force_meson_configure _name)
  ExternalProject_Add_Step(
    ${_name} force-meson-configure
    DEPENDEES patch
    DEPENDERS configure
    COMMAND ${EXEC} rm -rf <BINARY_DIR>/meson-*
    LOG 1)
endfunction()

set(cmake_conf_args
  -GNinja
  -DCMAKE_BUILD_TYPE=Release
  -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE}
  -DCMAKE_INSTALL_PREFIX=${MINGW_INSTALL_PREFIX}
  -DBUILD_SHARED_LIBS=OFF
  -DBUILD_STATIC_LIBS=ON
  -DBUILD_TESTING=OFF
  -DBUILD_TESTS=OFF
  -DENABLE_SHARED_LIB=OFF
  -DENABLE_SHARED=OFF
  -DENABLE_STATIC_LIB=ON
  -DENABLE_STATIC=ON
  -DENABLE_TESTS=OFF
)
set(meson_conf_args
  --prefix=${MINGW_INSTALL_PREFIX}
  --libdir=${MINGW_INSTALL_PREFIX}/lib
  --cross-file=${MESON_CROSS}
  --buildtype=release
  --default-library=static
  --optimization=3
  --prefer-static
)
set(autotools_conf_args
  --host=x86_64-w64-mingw32
  --prefix=${MINGW_INSTALL_PREFIX}
  --disable-shared
  --enable-static
)

list(
  APPEND
  ep
  winrt-headers
  gmp
  uchardet
  libsamplerate
  rubberband
  zlib
  bzip2
  libjpeg
  lcms2
  libpng
  libiconv
  luajit
  fribidi
  expat
  brotli
  freetype2
  harfbuzz
  libzimg
  fontconfig
  libunibreak
  libass
  libxml2
  vulkan-headers
  vulkan-loader
  spirv-cross
  shaderc
  fast-float
  glad
  xxhash
  libplacebo
  dav1d
  svtav1
  amf-headers
  aom
  lame
  libvpx
  libwebp
  nvcodec-headers
  ogg
  flac
  opus
  libopusenc
  vorbis
  theora
  x264
  x265
  libvpl
  directx-headers
  highway
  libjxl
  fdk-aac
  ffmpeg
  openal
  mujs
  mpv
  zstd
  cjson
  curl
  libsdl2
  minizip
  glew
  sqlite
  quake2pro
  quake3e
  quake3e-urbanterror
  quake3e-openarena
  xonotic
)

foreach(package IN LISTS ep)
  include(${CMAKE_CURRENT_SOURCE_DIR}/${package}.cmake)
  message(STATUS "Parsing package ${package}")
endforeach()

set(UPDATE_SCRIPT ${CMAKE_SOURCE_DIR}/packages/update-repo.sh)
add_custom_target(
  update
  USES_TERMINAL
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  COMMAND chmod 755 ${UPDATE_SCRIPT}
  COMMAND ${EXEC} ${UPDATE_SCRIPT}
  COMMENT "Updating git repo")
