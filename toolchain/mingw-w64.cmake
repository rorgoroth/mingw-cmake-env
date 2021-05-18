ExternalProject_Add(mingw-w64
    PREFIX mingw-w64-prefix
    URL https://github.com/mirror/mingw-w64/archive/refs/tags/v8.0.2.tar.gz
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1 LOG_UPDATE 1
)
