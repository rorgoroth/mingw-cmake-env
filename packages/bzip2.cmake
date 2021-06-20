ExternalProject_Add(bzip2
    URL https://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz
    URL_HASH MD5=67e051268d0c475ea773822f7500d0e5
    PATCH_COMMAND patch -p1 -i ${CMAKE_CURRENT_SOURCE_DIR}/bzip2-1-fixes.patch
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${MAKE} libbz2.a
        PREFIX=${MINGW_INSTALL_PREFIX}
        CC=${TARGET_ARCH}-gcc
        AR=${TARGET_ARCH}-ar
        RANLIB=${TARGET_ARCH}-ranlib
    INSTALL_COMMAND install -d ${MINGW_INSTALL_PREFIX}/lib
        COMMAND install -m644 libbz2.a ${MINGW_INSTALL_PREFIX}/lib/
        COMMAND install -d ${MINGW_INSTALL_PREFIX}/include
        COMMAND install -m644 bzlib.h ${MINGW_INSTALL_PREFIX}/include/
    BUILD_IN_SOURCE 1
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

extra_step(bzip2)
