include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

foreach(name IN ITEMS a b)
  set(package "multiple-packages_${name}")
  set(export "${package}Targets")

  install(
      TARGETS "multiple-packages_${name}"
      EXPORT "${export}"
      RUNTIME COMPONENT "${package}_Runtime"
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
      COMPONENT "${package}_Development"
  )

  install(
      EXPORT "${export}"
      NAMESPACE multiple-packages::
      DESTINATION "${${package}_INSTALL_CMAKEDIR}"
      COMPONENT "${package}_Development"
  )
endforeach()

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
