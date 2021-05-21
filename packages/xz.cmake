ExternalProject_Add(xz
    GIT_REPOSITORY https://github.com/xz-mirror/xz.git
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} <SOURCE_DIR>/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --disable-doc
        --disable-lzmadec
        --disable-lzmainfo
        --disable-shared
        --disable-xz
        --disable-xzdec
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(xz)
extra_step(xz)
autogen(xz)
