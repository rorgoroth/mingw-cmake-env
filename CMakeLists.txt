cmake_minimum_required(VERSION 3.27.0)
project(mingw-env)
enable_language(C ASM CXX)

function(colored_msg msg)
    if(NOT WIN32)
        string(ASCII 27 Esc)
        message("${Esc}[35m${msg}${Esc}[m")
    else()
        message("${msg}")
    endif()
endfunction()

macro(print_mingw64_banner)
    colored_msg("")
    colored_msg("  ███╗░░░███╗██╗███╗░░██╗░██████╗░░██╗░░░░░░░██╗░█████╗░░░██╗██╗")
    colored_msg("  ████╗░████║██║████╗░██║██╔════╝░░██║░░██╗░░██║██╔═══╝░░██╔╝██║")
    colored_msg("  ██╔████╔██║██║██╔██╗██║██║░░██╗░░╚██╗████╗██╔╝██████╗░██╔╝░██║")
    colored_msg("  ██║╚██╔╝██║██║██║╚████║██║░░╚██╗░░████╔═████║░██╔══██╗███████║")
    colored_msg("  ██║░╚═╝░██║██║██║░╚███║╚██████╔╝░░╚██╔╝░╚██╔╝░╚█████╔╝╚════██║")
    colored_msg("  ╚═╝░░░░░╚═╝╚═╝╚═╝░░╚══╝░╚═════╝░░░░╚═╝░░░╚═╝░░░╚════╝░░░░░░╚═╝")
    colored_msg("")
endmacro()

macro(print_header)
    print_mingw64_banner()
endmacro()

print_header()

include(ExternalProject)
include(ProcessorCount)

if(NOT CMAKE_GENERATOR STREQUAL "Ninja")
  message(
    FATAL_ERROR "Generator “${CMAKE_GENERATOR}” is unsupported!\nInstall Ninja.")
endif()

ProcessorCount(CPU_COUNT)
if(CPU_COUNT EQUAL 0)
  set(CPU_COUNT 1)
endif()

set(MAKEJOBS ${CPU_COUNT})
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

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/toolchain/exec-nolto.in
               ${CMAKE_CURRENT_BINARY_DIR}/exec-nolto @ONLY)
set(EXEC-NLTO ${CMAKE_CURRENT_BINARY_DIR}/exec-nolto)
set(MAKE-NLTO ${EXEC-NLTO} make -j${MAKEJOBS})
set(NINJA-NLTO ${EXEC-NLTO} ninja -j${MAKEJOBS})

string(TIMESTAMP BUILDDATE "%Y%m%d" UTC)

add_subdirectory(toolchain)
add_subdirectory(packages)
