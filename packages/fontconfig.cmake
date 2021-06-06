ExternalProject_Add(fontconfig
    DEPENDS
        expat
        freetype2
        libiconv
        zlib
    GIT_REPOSITORY https://gitlab.freedesktop.org/fontconfig/fontconfig.git
    UPDATE_COMMAND ""
    GIT_SHALLOW 1
    PATCH_COMMAND ${EXEC} git am ${CMAKE_CURRENT_SOURCE_DIR}/fontconfig-*.patch
    CONFIGURE_COMMAND ${EXEC} dash <SOURCE_DIR>/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --disable-docs
        --disable-shared
        --enable-iconv
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(fontconfig)
extra_step(fontconfig)
autogen(fontconfig)
