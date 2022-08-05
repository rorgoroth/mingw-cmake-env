cmake_policy(SET CMP0114 OLD)
cmake_policy(SET CMP0135 NEW)

list(
  APPEND
  ep
  binutils
  mingw-w64
  widl
  mingw-w64-headers
  gcc-base
  mingw-w64-crt
  winpthreads
  gendef
  gcc
  )

foreach(package IN LISTS ep)
  include(${CMAKE_CURRENT_SOURCE_DIR}/${package}.cmake)
  message(STATUS "Parsing package ${package}")
endforeach()
