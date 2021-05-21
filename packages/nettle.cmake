ExternalProject_Add(nettle
    GIT_REPOSITORY https://github.com/gnutls/nettle.git
    GIT_SHALLOW 1
    PATCH_COMMAND ${EXEC} git am ${CMAKE_CURRENT_SOURCE_DIR}/nettle-*.patch
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} <SOURCE_DIR>/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --disable-documentation
        --disable-openssl
        --disable-shared
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(nettle)
autoreconf(nettle)
extra_step(nettle)
