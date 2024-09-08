function(force_rebuild_git _name)
  get_property(
    git_tag
    TARGET ${_name}
    PROPERTY _EP_GIT_TAG)
  get_property(
    git_remote_name
    TARGET ${_name}
    PROPERTY _EP_GIT_REMOTE_NAME)

  if("${git_remote_name}" STREQUAL "" AND NOT "${git_tag}" STREQUAL "")
    # GIT_REMOTE_NAME is not set when commit hash is specified
    set(pull "")
  else()
    set(git_tag "@{u}")
    set(pull COMMAND git pull)
  endif()

  ExternalProject_Add_Step(
    ${_name} force-update
    INDEPENDENT 1
    DEPENDEES download update
    DEPENDERS patch build install
    COMMAND sh -c "git am --abort 2> /dev/null || true"
    COMMAND git reset --hard ${git_tag} ${pull}
    WORKING_DIRECTORY <SOURCE_DIR>
    LOG 1)
endfunction()

list(
  APPEND
  ep
  llvm
  )

foreach(package IN LISTS ep)
  include(${CMAKE_CURRENT_SOURCE_DIR}/${package}.cmake)
  message(STATUS "Parsing package ${package}")
endforeach()