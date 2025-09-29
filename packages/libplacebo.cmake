get_property(src_fast-float TARGET fast-float PROPERTY _EP_SOURCE_DIR)
get_property(src_glad TARGET glad PROPERTY _EP_SOURCE_DIR)
get_property(src_vulkan-headers TARGET vulkan-headers PROPERTY _EP_SOURCE_DIR)

ExternalProject_Add(
  libplacebo
  DEPENDS fast-float
          glad
          lcms2
          shaderc
          spirv-cross
          vulkan-loader
          xxhash
  URL https://github.com/haasn/libplacebo/archive/refs/tags/v7.351.0.tar.gz
  URL_HASH MD5=2bd64e3591e4689b29669cd915aa22a4
  DOWNLOAD_EXTRACT_TIMESTAMP 1
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND ""
    COMMAND sh -c "rm -rf <SOURCE_DIR>/3rdparty/fast_float"
    COMMAND sh -c "ln -s ${src_fast-float} <SOURCE_DIR>/3rdparty/fast_float"
    COMMAND sh -c "rm -rf <SOURCE_DIR>/3rdparty/glad"
    COMMAND sh -c "ln -s ${src_glad} <SOURCE_DIR>/3rdparty/glad"
    COMMAND sh -c "rm -rf <SOURCE_DIR>/3rdparty/Vulkan-Headers"
    COMMAND sh -c "ln -s ${src_vulkan-headers} <SOURCE_DIR>/3rdparty/Vulkan-Headers"
    COMMAND ${EXEC} meson setup --reconfigure <BINARY_DIR> <SOURCE_DIR>
    ${meson_conf_args}
    -Dd3d11=enabled
    -Ddemos=false
    -Ddovi=enabled
    -Dgl-proc-addr=enabled
    -Dglslang=disabled
    -Dlcms=enabled
    -Dlibdovi=disabled
    -Dopengl=enabled
    -Dshaderc=enabled
    -Dvk-proc-addr=enabled
    -Dvulkan=enabled
    -Dvulkan-registry='${MINGW_INSTALL_PREFIX}/share/vulkan/registry/vk.xml'
    -Dxxhash=enabled
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ${NINJA} -C <BINARY_DIR> install
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

force_rebuild_git(libplacebo)
force_meson_configure(libplacebo)
