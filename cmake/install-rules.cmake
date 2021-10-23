include(CMakePackageConfigHelpers)
include(CPackComponent)
include(GNUInstallDirs)

foreach(name IN ITEMS a b)
  set(component "multiple-packages_${name}")
  set(export "multiple-packages_${name}Targets")
  set(package "multiple-packages_${name}")

  install(
      TARGETS "multiple-packages_${name}"
      EXPORT "${export}"
      RUNTIME COMPONENT "${component}_Runtime"
  )

  configure_file(cmake/install-config.cmake.in "${package}Config.cmake" @ONLY)

  write_basic_package_version_file(
      "${package}ConfigVersion.cmake"
      COMPATIBILITY SameMajorVersion
  )

  # Allow package maintainers to freely override the path for the configs
  set(
      "${package}_INSTALL_CMAKEDIR" "${CMAKE_INSTALL_DATADIR}/${package}"
      CACHE PATH "CMake package config location relative to the install prefix"
  )
  mark_as_advanced("${package}_INSTALL_CMAKEDIR")

  install(
      FILES
      "${PROJECT_BINARY_DIR}/${package}Config.cmake"
      "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
      DESTINATION "${${package}_INSTALL_CMAKEDIR}"
      COMPONENT "${component}_Development"
  )

  install(
      EXPORT "${export}"
      NAMESPACE multiple-packages::
      DESTINATION "${${package}_INSTALL_CMAKEDIR}"
      COMPONENT "${component}_Development"
  )

  # These become noop if the project is not top level, because the CPack module
  # is not included here
  cpack_add_component_group("${package}")
  cpack_add_component("${component}_Development" GROUP "${package}")
  cpack_add_component("${component}_Runtime" GROUP "${package}")
endforeach()

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
