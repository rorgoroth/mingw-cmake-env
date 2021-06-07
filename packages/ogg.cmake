ExternalProject_Add(ogg
    URL https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.5.tar.xz
    URL_HASH SHA1=5a368421a636f7faa4c2f662857cb507dffd7c99
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} dash <SOURCE_DIR>/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --disable-shared
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

extra_step(ogg)
autoreconf(ogg)
