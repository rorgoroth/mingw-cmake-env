cmake_minimum_required(VERSION 3.20.0)
project(mingw-env C)
include(ExternalProject)
include(ProcessorCount)

if(NOT CMAKE_GENERATOR STREQUAL "Ninja")
  message(
    FATAL_ERROR "Generator “${CMAKE_GENERATOR}” is unsupported!\nTry Ninja if you encounter problems.")
endif()

set(TARGET_ARCH
    "x86_64-w64-mingw32"
    CACHE STRING "The target architecture for this toolchain.")
string(REGEX MATCH "^[^-]+" TARGET_CPU ${TARGET_ARCH})

execute_process(COMMAND ${CMAKE_C_COMPILER} -dumpmachine OUTPUT_VARIABLE HOST_ARCH)
string(REGEX MATCH "^[^-]+" HOST_CPU ${HOST_ARCH})

if(TARGET_CPU MATCHES "x86_64")
  set(TARGET_CPU_FAMILY "x86_64")
  set(TARGET_BITS 64)
else()
  message(
    FATAL_ERROR "Only 64bit is supported.")
endif()

ProcessorCount(CPU_COUNT)
if(CPU_COUNT EQUAL 0)
  set(CPU_COUNT 1)
endif()

set(MAKEJOBS ${CPU_COUNT})
# set(MAKEJOBS 8)
set(MAKEJOBS
    ${MAKEJOBS}
    CACHE STRING "Number of parallel processes to run for each package build")

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX
      "${CMAKE_CURRENT_BINARY_DIR}/install"
      CACHE PATH "Default install path" FORCE)
endif()
set(MINGW_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX}/mingw)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/toolchain/toolchain.cmake.in
               ${CMAKE_CURRENT_BINARY_DIR}/toolchain.cmake @ONLY)
set(TOOLCHAIN_FILE ${CMAKE_CURRENT_BINARY_DIR}/toolchain.cmake)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/toolchain/meson_cross.txt.in
               ${CMAKE_CURRENT_BINARY_DIR}/meson_cross.txt @ONLY)
set(MESON_CROSS ${CMAKE_CURRENT_BINARY_DIR}/meson_cross.txt)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/toolchain/exec.in
               ${CMAKE_CURRENT_BINARY_DIR}/exec @ONLY)
set(EXEC ${CMAKE_CURRENT_BINARY_DIR}/exec)

set(MAKE ${EXEC} make -j${MAKEJOBS})

set(NINJA ${EXEC} ninja -j${MAKEJOBS})

string(TIMESTAMP BUILDDATE "%Y%m%d" UTC)

add_subdirectory(toolchain)
add_subdirectory(packages)
