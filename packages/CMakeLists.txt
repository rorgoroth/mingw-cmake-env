# download/update/patch steps of all packages run up front and in parallel, see "run.sh fetch".
function(ExternalProject_Add _ep_name)
  set(_deps "")
  set(_code "_ExternalProject_Add([==[${_ep_name}]==]")
  set(_in_deps FALSE)
  if(ARGC GREATER 1)
    math(EXPR _last "${ARGC} - 1")
    foreach(_i RANGE 1 ${_last})
      set(_arg "${ARGV${_i}}")
      if(_arg STREQUAL "DEPENDS")
        set(_in_deps TRUE)
      elseif(_in_deps AND NOT _arg MATCHES "^[A-Z][A-Z0-9_]*$")
        list(APPEND _deps "${_arg}")
      else()
        set(_in_deps FALSE)
        string(APPEND _code " [==[${_arg}]==]")
      endif()
    endforeach()
  endif()
  string(APPEND _code ")")
  cmake_language(EVAL CODE "${_code}")

  set(_dep_stamps "")
  foreach(_dep IN LISTS _deps)
    set_property(GLOBAL APPEND PROPERTY _EP_DEPENDENCY_PAIRS "${_ep_name}:${_dep}")
    list(APPEND _dep_stamps
      "${CMAKE_CURRENT_BINARY_DIR}/${_dep}-prefix/src/${_dep}-stamp/${_dep}-done")
  endforeach()
  if(_dep_stamps)
    ExternalProject_Add_StepDependencies(${_ep_name} configure ${_dep_stamps})
  endif()

  # The toolchain and rustup are only downloaded when they are built on purpose.
  if(NOT _ep_name STREQUAL "llvm" AND NOT _ep_name STREQUAL "rustup")
    set_property(GLOBAL APPEND PROPERTY _EP_FETCH_STAMPS
      "${CMAKE_CURRENT_BINARY_DIR}/${_ep_name}-prefix/src/${_ep_name}-stamp/${_ep_name}-patch")
  endif()
endfunction()

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
  set_property(GLOBAL APPEND PROPERTY _EP_FETCH_STAMPS
    "${CMAKE_CURRENT_BINARY_DIR}/${_name}-prefix/src/${_name}-stamp/${_name}-force-git-patch")
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

# CFLAGS/CXXFLAGS from the exec scripts are picked up by CMake automatically,
# but the Release configuration appends "-O3 -DNDEBUG" after them, so OPTIM
# would never take effect. Set it explicitly (the single quotes survive the
# "eval" in exec/exec-nolto). Packages that need extra flags must use
# -DCMAKE_<LANG>_FLAGS_INIT, an explicit -DCMAKE_<LANG>_FLAGS replaces the
# environment flags instead of extending them.
set(cmake_conf_args
  -GNinja
  -DCMAKE_C_COMPILER_LAUNCHER=ccache
  -DCMAKE_CXX_COMPILER_LAUNCHER=ccache
  -DCMAKE_ASM_COMPILER_LAUNCHER=ccache
  -DCMAKE_BUILD_TYPE=Release
  -DCMAKE_C_FLAGS_RELEASE='-${OPTIM} -DNDEBUG'
  -DCMAKE_CXX_FLAGS_RELEASE='-${OPTIM} -DNDEBUG'
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
  -DCMAKE_POLICY_VERSION_MINIMUM=3.5
)
set(meson_conf_args
  --prefix=${MINGW_INSTALL_PREFIX}
  --libdir=${MINGW_INSTALL_PREFIX}/lib
  --cross-file=${MESON_CROSS}
  --buildtype=plain
  --default-library=static
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
  llvm
  rustup
  winrt-headers
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
  zstd
  libpsl
  openssl
  c-ares
  nghttp2
  nghttp3
  ngtcp2
  curl
  freetype2
  harfbuzz
  graphengine
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
  opusfile
  vorbis
  theora
  x264
  x265
  libvpl
  directx-headers
  highway
  libjxl
  fdk-aac
  sdl3
  sdl2-compat
  spirv-headers
  librempeg
  ffmpeg
  mujs
  mpv
  cjson
  minizip
  glew
  sdl3-image
  sdl3-mixer
  sdl3-ttf
  sqlite
  quake3e
  quake3e-urbanterror
  xonotic
)

foreach(package IN LISTS ep)
  include(${CMAKE_CURRENT_SOURCE_DIR}/${package}.cmake)
#  message(STATUS "Parsing package ${package}")
endforeach()

# DEPENDS on a package that does not exist would otherwise only show up as a
# missing stamp file when building.
get_property(dependency_pairs GLOBAL PROPERTY _EP_DEPENDENCY_PAIRS)
foreach(pair IN LISTS dependency_pairs)
  string(REPLACE ":" ";" pair "${pair}")
  list(GET pair 0 dependent)
  list(GET pair 1 dependency)
  if(NOT TARGET ${dependency})
    message(FATAL_ERROR "${dependent}: unknown package in DEPENDS: ${dependency}")
  endif()
endforeach()

# Download, update and patch the sources of all packages, nothing is
# configured or built. Run it with a high -j before the actual build, see
# "run.sh fetch".
get_property(fetch_stamps GLOBAL PROPERTY _EP_FETCH_STAMPS)
add_custom_target(
  fetch
  DEPENDS ${fetch_stamps}
  COMMENT "Fetched and patched all package sources")

set(UPDATE_SCRIPT ${CMAKE_SOURCE_DIR}/packages/update-repo.sh)
add_custom_target(
  update
  USES_TERMINAL
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  COMMAND ${EXEC} bash ${UPDATE_SCRIPT}
  COMMENT "Updating Git Repositories...")
