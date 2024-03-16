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
          lcms2
          lame
          libass
          libjxl
          libopusenc
          libplacebo
          libpng
          libvpx
          libwebp
          libxml2
          libzimg
          nvcodec-headers
          libvpl
          rubberband
          shaderc
          spirv-cross
          svtav1
          vorbis
          vulkan-loader
          x264
          x265
  GIT_REPOSITORY https://github.com/FFmpeg/FFmpeg.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} <SOURCE_DIR>/configure
    --cross-prefix=${TARGET_ARCH}-
    --prefix=${MINGW_INSTALL_PREFIX}
    --arch=${TARGET_CPU}
    --target-os=mingw32
    --target-exec=wine
    --pkg-config-flags=--static
    --disable-debug
    --disable-decoder=libaom_av1
    --disable-doc
    --disable-ffplay
    --disable-ffprobe
    --disable-htmlpages
    --disable-manpages
    --disable-podpages
    --disable-sdl2
    --disable-txtpages
    --disable-vaapi
    --disable-vdpau
    --disable-videotoolbox
    --enable-amf
    --enable-cross-compile
    --enable-gmp
    --enable-gpl --enable-version3 --enable-nonfree
    --enable-lcms2
    --enable-libaom
    --enable-libass
    --enable-libdav1d
    --enable-libfontconfig
    --enable-libharfbuzz
    --enable-libjxl
    --enable-libmp3lame
    --enable-libopus
    --enable-libplacebo
    --enable-libshaderc
    --enable-librubberband
    --enable-libsvtav1
    --enable-libvorbis
    --enable-libvpl
    --enable-libvpx
    --enable-libwebp
    --enable-libx264
    --enable-libx265
    --enable-libxml2
    --enable-libzimg
    --enable-lto=thin
    --enable-nvdec
    --enable-nvenc
    --enable-runtime-cpudetect
    --enable-schannel
    --enable-vulkan
    "--extra-libs='-lstdc++ -lpthread'" # libplacebo/shaderc
  BUILD_COMMAND ${MAKE}
  INSTALL_COMMAND ${MAKE} install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

ExternalProject_Add_Step(
  ffmpeg copy-binary
  DEPENDEES install
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <BINARY_DIR>/ffmpeg.exe
    ${CMAKE_CURRENT_BINARY_DIR}/ffmpeg-package/ffmpeg.exe)

force_rebuild_git(ffmpeg)
clean_build(ffmpeg copy-binary)
