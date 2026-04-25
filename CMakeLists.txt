cmake_minimum_required(VERSION 3.30)
project(mingw-env LANGUAGES C ASM CXX)

include(ExternalProject)
include(ProcessorCount)
include(CheckCCompilerFlag)

# Generator Check
if(NOT CMAKE_GENERATOR STREQUAL "Ninja")
    message(FATAL_ERROR "Generator '${CMAKE_GENERATOR}' is unsupported. Please install and select Ninja.")
endif()

# Processor Count
ProcessorCount(CPU_COUNT)
if(CPU_COUNT EQUAL 0)
    set(CPU_COUNT 1)
endif()
set(MAKEJOBS ${CPU_COUNT} CACHE STRING "Number of parallel processes for build")

# Optimizations
set(CPUTUNE "x86-64-v3" CACHE STRING "Target 'march' optimization (e.g. native, x86-64-v3, x86-64-v2)")
set(OPTIM "O3" CACHE STRING "Optimization level (e.g., O2, O3)")

# Validate CPUTUNE
set(VALID_ARCHS "native" "x86-64-v4" "x86-64-v3" "x86-64-v2" "x86-64")
if(NOT CPUTUNE IN_LIST VALID_ARCHS)
    message(WARNING "CPUTUNE '${CPUTUNE}' is not in the recommended list. Proceeding anyway, but ensure your compiler supports it.")
endif()

# Install Prefix
if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_BINARY_DIR}/install" CACHE PATH "Default install path" FORCE)
endif()
set(MINGW_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX}/x86_64-w64-mingw32)

# Configuration Files
set(CONFIG_FILES
    packages/ccache.conf.in
    packages/toolchain.cmake.in
    packages/meson_cross.txt.in
    packages/exec.in
    packages/exec-nolto.in
)

foreach(file ${CONFIG_FILES})
    if(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${file}")
        message(FATAL_ERROR "Missing configuration template: ${file}")
    endif()
endforeach()

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/packages/ccache.conf.in
               ${MINGW_INSTALL_PREFIX}/ccache/ccache.conf @ONLY)
set(CCACHE_CONF ${MINGW_INSTALL_PREFIX}/ccache/ccache.conf)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/packages/toolchain.cmake.in
               ${CMAKE_CURRENT_BINARY_DIR}/toolchain.cmake @ONLY)
set(TOOLCHAIN_FILE ${CMAKE_CURRENT_BINARY_DIR}/toolchain.cmake)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/packages/meson_cross.txt.in
               ${CMAKE_CURRENT_BINARY_DIR}/meson_cross.txt @ONLY)
set(MESON_CROSS ${CMAKE_CURRENT_BINARY_DIR}/meson_cross.txt)

# Generate exec scripts
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/packages/exec.in
               ${CMAKE_CURRENT_BINARY_DIR}/exec @ONLY)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/packages/exec-nolto.in
               ${CMAKE_CURRENT_BINARY_DIR}/exec-nolto @ONLY)

set(EXEC ${CMAKE_CURRENT_BINARY_DIR}/exec)
set(EXEC-NLTO ${CMAKE_CURRENT_BINARY_DIR}/exec-nolto)

# Set executable permissions on generated scripts
if(UNIX)
    execute_process(COMMAND chmod +x ${EXEC} ${EXEC-NLTO}
                    RESULT_VARIABLE CHMOD_RESULT)
    if(NOT CHMOD_RESULT EQUAL 0)
        message(WARNING "Failed to set executable permissions on generated scripts.")
    endif()
endif()

set(MAKE ${EXEC} make -j${MAKEJOBS})
set(NINJA ${EXEC} ninja -j${MAKEJOBS})
set(MAKE-NLTO ${EXEC-NLTO} make -j${MAKEJOBS})
set(NINJA-NLTO ${EXEC-NLTO} ninja -j${MAKEJOBS})

string(TIMESTAMP BUILDDATE "%Y%m%d" UTC)

# Add Subdirectories
add_subdirectory(packages)