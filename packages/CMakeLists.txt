cmake_policy(SET CMP0114 OLD)
cmake_policy(SET CMP0135 NEW)

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
    DEPENDEES download update
    DEPENDERS patch build install
    COMMAND git reset --hard ${git_tag} ${pull}
    WORKING_DIRECTORY <SOURCE_DIR>
    LOG 1)
endfunction()

function(autogen _name)
  ExternalProject_Add_Step(
    ${_name} autogen
    DEPENDEES download update patch
    DEPENDERS configure
    COMMAND ${EXEC} ./autogen.sh -V
    WORKING_DIRECTORY <SOURCE_DIR>
    LOG 1)
endfunction()

function(autoreconf _name)
  ExternalProject_Add_Step(
    ${_name} autoreconf
    DEPENDEES download update patch
    DEPENDERS configure
    COMMAND ${EXEC} autoreconf -i
    WORKING_DIRECTORY <SOURCE_DIR>
    LOG 1)
endfunction()

function(force_meson_configure _name)
  ExternalProject_Add_Step(
    ${_name} force-meson-configure
    DEPENDERS configure
    COMMAND ${EXEC} rm -rf <BINARY_DIR>/meson-*
    LOG 1)
endfunction()

list(
  APPEND
  ep
  gmp
  uchardet
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
  glad
  libplacebo
  dav1d
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
  speex
  vorbis
  x264
  ffmpeg
  openal
  mpv
  zstd
  curl
  libsdl2
  minizip
  glew
  sqlite
  libuv
  c-ares
  aria2c
  iortcw
  iortcw-mp
  quake3e
  quake3e-urbanterror
  quake3e-openarena
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
