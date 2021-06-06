ExternalProject_Add(libarchive
    DEPENDS
        bzip2
        expat
        lzo
        nettle
        xz
        zlib
    GIT_REPOSITORY https://github.com/libarchive/libarchive.git
    GIT_SHALLOW 1
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} dash <SOURCE_DIR>/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --disable-bsdcat
        --disable-bsdcpio
        --disable-bsdtar
        --disable-shared
        --with-lzo2
        --without-cng
        --without-openssl
        --without-xml2
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libarchive)
extra_step(libarchive)
autoreconf(libarchive)

