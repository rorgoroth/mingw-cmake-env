ExternalProject_Add(
  ffmpeg
  DEPENDS amf-headers
          aom
          bzip2
          dav1d
          flac
          gmp
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
    --cross-prefix=${TARGET_ARCH}-
    --prefix=${MINGW_INSTALL_PREFIX}
    --arch=${TARGET_CPU}
    --target-os=mingw32
    --target-exec=wine
    --pkg-config-flags=--static
    --disable-decoder=libaom_av1
    --disable-doc
    --disable-ffplay
    --disable-ffprobe
    --disable-filters
      --enable-filter=aresample
      --enable-filter=blurdetect
      --enable-filter=convolution
      --enable-filter=copy
      --enable-filter=crop
      --enable-filter=cropdetect
      --enable-filter=deband
      --enable-filter=deblock
      --enable-filter=gblur
      --enable-filter=rotate
      --enable-filter=scale
      --enable-filter=sobel
      --enable-filter=threshold
      --enable-filter=trim
    --disable-encoders
      --enable-encoder=aac
      --enable-encoder=aac_mf
      --enable-encoder=apng
      --enable-encoder=flac
      --enable-encoder=gif
      --enable-encoder=h264_amf
      --enable-encoder=h264_mf
      --enable-encoder=h264_nvenc
      --enable-encoder=hdr
      --enable-encoder=hevc_amf
      --enable-encoder=hevc_mf
      --enable-encoder=hevc_nvenc
      --enable-encoder=jpeg2000
      --enable-encoder=jpegls
      --enable-encoder=libaom_av1
      --enable-encoder=libmp3lame
      --enable-encoder=libopus
      --enable-encoder=libspeex
      --enable-encoder=libvorbis
      --enable-encoder=libvpx_vp8
      --enable-encoder=libvpx_vp9
      --enable-encoder=libwebp
      --enable-encoder=libwebp_anim
      --enable-encoder=libx264
      --enable-encoder=libx264rgb
      --enable-encoder=ljpeg
      --enable-encoder=mjpeg
      --enable-encoder=mp3_mf
      --enable-encoder=mpeg4
      --enable-encoder=opus
      --enable-encoder=png
      --enable-encoder=rawvideo
      --enable-encoder=roq
      --enable-encoder=roq_dpcm
      --enable-encoder=vorbis
      --enable-encoder=wavpack
      --enable-encoder=zlib
    --disable-muxers
      --enable-muxer=ac3
      --enable-muxer=apng
      --enable-muxer=ass
      --enable-muxer=avi
      --enable-muxer=flac
      --enable-muxer=gif
      --enable-muxer=h264
      --enable-muxer=hevc
      --enable-muxer=image2
      --enable-muxer=image2pipe
      --enable-muxer=m4v
      --enable-muxer=matroska
      --enable-muxer=matroska_audio
      --enable-muxer=mjpeg
      --enable-muxer=mkvtimestamp_v2
      --enable-muxer=mp3
      --enable-muxer=mp4
      --enable-muxer=mpegts
      --enable-muxer=mpjpeg
      --enable-muxer=oga
      --enable-muxer=ogg
      --enable-muxer=ogv
      --enable-muxer=opus
      --enable-muxer=rawvideo
      --enable-muxer=roq
      --enable-muxer=wav
      --enable-muxer=webm
      --enable-muxer=webp
    --disable-htmlpages
    --disable-manpages
    --disable-podpages
    --disable-postproc
    --disable-sdl2
    --disable-txtpages
    --enable-amf
    --enable-cross-compile
    --enable-gmp
    --enable-gpl
      --enable-version3
      --enable-nonfree
    --enable-libaom
    --enable-libass
    --enable-libdav1d
    --enable-libmp3lame
    --enable-libopus
    --enable-libplacebo
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
    "--extra-libs='-lstdc++'" # Needed by shaderc
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
