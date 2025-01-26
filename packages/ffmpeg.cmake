ExternalProject_Add(
  ffmpeg
  DEPENDS amf-headers
          aom
          bzip2
          dav1d
          fdk-aac
          flac
          fontconfig
          harfbuzz
          lcms2
          lame
          libass
          libjxl
          libopusenc
          libplacebo
          libpng
          libsdl2
          libvpl
          libvpx
          libwebp
          libxml2
          libzimg
          nvcodec-headers
          rubberband
          shaderc
          spirv-cross
          svtav1
          vorbis
          vulkan-loader
          x264
          x265
  GIT_REPOSITORY https://github.com/librempeg/librempeg.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  PATCH_COMMAND ${EXEC} git am -3 ${CMAKE_CURRENT_SOURCE_DIR}/ffmpeg-0001-libsvtav1-FFmpeg-v7-fix.patch
  CONFIGURE_COMMAND
    ${EXEC} <SOURCE_DIR>/configure
    --cc='ccache x86_64-w64-mingw32-gcc' --cxx='ccache x86_64-w64-mingw32-gcc'
    --cross-prefix=x86_64-w64-mingw32-
    --prefix=${MINGW_INSTALL_PREFIX}
    --arch=x86_64
    --target-os=mingw32
    --target-exec=wine
    --pkg-config-flags=--static
    --disable-debug
    --disable-decoder=libaom_av1
    --disable-doc
    --disable-htmlpages
    --disable-manpages
    --disable-podpages
    --disable-txtpages
    --disable-vaapi
    --disable-vdpau
    --disable-videotoolbox
    --enable-amf
    --enable-cross-compile
    --enable-ffmpeg
    --enable-ffplay
    --enable-ffprobe
    --enable-gpl --enable-version3 --enable-nonfree
    --enable-lcms2
    --enable-libaom
    --enable-libass
    --enable-libdav1d
    --enable-libfdk-aac
    --enable-libfontconfig
    --enable-libharfbuzz
    --enable-libjxl
    --enable-libmp3lame
    --enable-libopus
    --enable-libplacebo
    --enable-librubberband
    --enable-libshaderc
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
    --enable-sdl2
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

ExternalProject_Add_Step(
  ffmpeg full-copy-binary
  DEPENDEES install
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <BINARY_DIR>/ffmpeg.exe
    ${CMAKE_CURRENT_BINARY_DIR}/ffmpeg-full-package/ffmpeg.exe
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <BINARY_DIR>/ffplay.exe
    ${CMAKE_CURRENT_BINARY_DIR}/ffmpeg-full-package/ffplay.exe
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <BINARY_DIR>/ffprobe.exe
    ${CMAKE_CURRENT_BINARY_DIR}/ffmpeg-full-package/ffprobe.exe)

force_rebuild_git(ffmpeg)
