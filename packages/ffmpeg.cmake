ExternalProject_Add(
  ffmpeg
  DEPENDS amf-headers
          aom
          bzip2
          dav1d
          flac
          fontconfig
          gmp
          harfbuzz
          lame
          libass
          libopusenc
          libplacebo
          libpng
          libvpx
          libwebp
          libxml2
          libzimg
          nvcodec-headers
          onevpl
          shaderc
          speex
          spirv-cross
          vorbis
          vulkan-loader
          x264
  GIT_REPOSITORY https://github.com/FFmpeg/FFmpeg.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} <SOURCE_DIR>/configure
    --cross-prefix=x86_64-w64-mingw32-
    --prefix=${MINGW_INSTALL_PREFIX}
    --arch=x86_64
    --target-os=mingw32
    --target-exec=wine
    --pkg-config-flags=--static
    --disable-decoder=libaom_av1
    --disable-doc
    --disable-ffplay
    --disable-ffprobe
    --disable-htmlpages
    --disable-manpages
    --disable-podpages
    --disable-postproc
    --disable-sdl2
    --disable-txtpages
    --disable-vaapi
    --disable-vdpau
    --disable-videotoolbox
    --enable-amf
    --enable-cross-compile
    --enable-gmp
    --enable-gpl --enable-version3 --enable-nonfree
    --enable-libaom
    --enable-libass
    --enable-libdav1d
    --enable-libfontconfig
    --enable-libharfbuzz
    --enable-libmp3lame
    --enable-libopus
    --enable-libplacebo
    --enable-libshaderc
    --enable-libspeex
    --enable-libvorbis
    --enable-libvpl
    --enable-libvpx
    --enable-libwebp
    --enable-libx264
    --enable-libxml2
    --enable-libzimg
    --enable-nvdec
    --enable-nvenc
    --enable-runtime-cpudetect
    --enable-schannel
    --enable-vulkan
    "--extra-libs='-lstdc++ -lpng'"
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

ExternalProject_Add_Step(
  ffmpeg copy-binary
  DEPENDEES build
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <BINARY_DIR>/ffmpeg.exe
    ${CMAKE_CURRENT_BINARY_DIR}/ffmpeg-package/ffmpeg.exe)

force_rebuild_git(ffmpeg)
