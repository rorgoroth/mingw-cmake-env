ExternalProject_Add(lzo
    URL http://www.oberhumer.com/opensource/lzo/download/lzo-2.10.tar.gz
    URL_HASH MD5=39d3f3f9c55c87b1e5d6888e1420f4b5
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} <SOURCE_DIR>/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --disable-shared
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

extra_step(lzo)
