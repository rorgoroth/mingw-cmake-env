ExternalProject_Add(expat
    URL "https://github.com/libexpat/libexpat/releases/download/R_2_3_0/expat-2.3.0.tar.gz"
    URL_HASH SHA1=8928f1d87b2b475ebf1b0a5b1f27032c0fc99dbc
    CONFIGURE_COMMAND ${EXEC} <SOURCE_DIR>/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --disable-shared
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

extra_step(expat)
