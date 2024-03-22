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
    COMMAND git reset --hard ${git_tag} ${pull}
    WORKING_DIRECTORY <SOURCE_DIR>
    LOG 1)
endfunction()

function(clean_build _name _last_step)
  ExternalProject_Add_Step(
    ${_name} clean_build
    DEPENDEES ${_last_step}
    COMMAND sh -c "make -C <BINARY_DIR> clean > /dev/null 2>&1 || true"
    COMMAND sh -c "ninja -C <BINARY_DIR> clean > /dev/null 2>&1 || true"
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

list(
  APPEND
  ep
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
