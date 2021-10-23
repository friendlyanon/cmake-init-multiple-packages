cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    multiple-packages
    VERSION 0.1.0
    DESCRIPTION "Example project with multiple packages"
    HOMEPAGE_URL "https://example.com/"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare executables ----

foreach(name IN ITEMS a b)
  set(target "multiple-packages_${name}")
  add_executable("${target}" "source/${name}.cpp")
  add_executable("multiple-packages::${name}" ALIAS "${target}")

  set_target_properties(
      "${target}" PROPERTIES
      OUTPUT_NAME "${name}"
      EXPORT_NAME "${name}"
  )
endforeach()

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()
