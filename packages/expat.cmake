ExternalProject_Add(expat
    URL "https://github.com/libexpat/libexpat/releases/download/R_2_4_1/expat-2.4.1.tar.gz"
    URL_HASH SHA1=171c635c757e0ac9005f72b9578af021fddbcfb3
    CONFIGURE_COMMAND ${EXEC} dash <SOURCE_DIR>/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --disable-shared
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

extra_step(expat)
