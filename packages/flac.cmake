ExternalProject_Add(flac
    DEPENDS ogg
    GIT_REPOSITORY https://github.com/xiph/flac.git
    GIT_SHALLOW 1
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} dash <SOURCE_DIR>/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --disable-doxygen-docs
        --disable-examples
        --disable-oggtest
        --disable-shared
        --disable-stack-smash-protection
        --disable-thorough-tests
        --disable-xmms-plugin
        --enable-static
        CFLAGS='-D_FORTIFY_SOURCE=0'
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(flac)
extra_step(flac)
autogen(flac)
