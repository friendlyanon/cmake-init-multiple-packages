# multiple-packages

This project was generated by [cmake-init][1].  
It's heavily stripped down to focus on showing how to create multiple packages
from a single project.

## Component groups

This project has 2 component groups:

* `multiple-packages_a`
* `multiple-packages_b`

These component groups are defined using variables in the `group-a` and
`group-b` presets. The same result could have been achieved by using commands
from the `CPackComponent` module. Each component group has 2 components
associated to them, which are the runtime and development components.

Take a look at the [presets](CMakePresets.json) for more details.

## Packaging

Take a look at the [CI workflow](.github/workflows/ci.yml) for packaging.

If you want to test the commands on Windows, you have to:

* Use the `package-zip-win64` preset
* Build the `build/win64` directory using the `--config` flag
  * Example: `cmake --build build/win64 --config Release`
* `cd` into the `build/win64` directory and package using the `-C` flag
  * Example: `cd build/win64 && cpack -C Release`

These are not really Windows specific, but on Windows a VS generator is the
default and the VS generators are multi-config, as opposed to a single-config
generator like the `Unix Makefiles` one.

[1]: https://github.com/friendlyanon/cmake-init
