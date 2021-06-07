ExternalProject_Add(mingw-w64
    PREFIX mingw-w64-prefix
    URL https://github.com/mirror/mingw-w64/archive/refs/tags/v9.0.0.tar.gz
    URL_HASH SHA1=b971369b21d1df8b158eb0a261fbb641054e2fef
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1 LOG_UPDATE 1
)
