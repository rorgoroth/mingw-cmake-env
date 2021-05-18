ExternalProject_Add(mpv
    DEPENDS
        ffmpeg
        fribidi
        lcms2
        libarchive
        libass
        libiconv
        libjpeg
        libpng
        luajit
        rubberband
        uchardet
        openal-soft
        libsdl2
    GIT_REPOSITORY https://github.com/mpv-player/mpv.git
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC}
        PKG_CONFIG=pkg-config
        TARGET=${TARGET_ARCH}
        DEST_OS=win32
        <SOURCE_DIR>/waf configure
        --enable-static-build
        --disable-manpage-build
        --enable-lua
        --enable-sdl2
        --enable-libarchive
        --enable-uchardet
        --enable-rubberband
        --enable-lcms2
        --enable-openal
        --prefix=${MINGW_INSTALL_PREFIX}
    BUILD_COMMAND ${EXEC} <SOURCE_DIR>/waf
    INSTALL_COMMAND ""
    BUILD_IN_SOURCE 1
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

ExternalProject_Add_Step(mpv bootstrap
    DEPENDEES download
    DEPENDERS configure
    COMMAND <SOURCE_DIR>/bootstrap.py
    WORKING_DIRECTORY <SOURCE_DIR>
    LOG 1
)

ExternalProject_Add_Step(mpv strip-binary
    DEPENDEES build
    COMMAND ${EXEC} ${TARGET_ARCH}-objcopy --only-keep-debug <SOURCE_DIR>/build/mpv.exe <SOURCE_DIR>/build/mpv.debug
    COMMAND ${EXEC} ${TARGET_ARCH}-strip -s <SOURCE_DIR>/build/mpv.exe
    COMMAND ${EXEC} ${TARGET_ARCH}-strip -s <SOURCE_DIR>/build/mpv.com
    COMMENT "Stripping mpv binaries"
)

ExternalProject_Add_Step(mpv copy-binary
    DEPENDEES strip-binary
    COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/build/mpv.exe                     ${CMAKE_CURRENT_BINARY_DIR}/mpv-package/mpv.exe
    COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/build/mpv.com                     ${CMAKE_CURRENT_BINARY_DIR}/mpv-package/mpv.com
)

force_rebuild_git(mpv)
extra_step(mpv)
