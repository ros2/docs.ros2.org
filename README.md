## Generating static docs for a ros2 release

  - Build up to rclcpp in a clean ros2 workspace.
  - Download the Makefile to the base of that workspace or apply `-f PATH/TO/Makefile` to all `make` invocations below.
  - Update the release name in the Makefile.
  - Import the documentation repos into the workspace with `vcs import src < ros2_doc.repos`
  - Update ros2/ros_core_documentation as appropriate; install dependencies mentioned in its readme and Doxygen.
    - Specifically you'll want to update the release name, see: https://github.com/ros2/ros_core_documentation/pull/7
  - `mkdir doxygen_tag_files`and download external tag files there, e.g. http://en.cppreference.com/w/File:cppreference-doxygen-web.tag.xml (at Ardent that was the only one).
  - Update the Doxyfile of all packages listed in the makefile:
    - Uncomment the relevant line so that they will generate tag files.
    - Change the ROS 2 `TAGFILES` links so that they reference `docs.ros2.org/<release name>` instead of `latest`.
  - For each package that needs to document generated code (only `rcutils` and `rclcpp` at Ardent), install the package and uncomment the lines in its Doxyfile to allow reference to the generated files.
  - Run `make install` from the base of the workspace. This will generate and copy the docs into `src/ros2/docs.ros2.org/<release_name>`.
  - Check that the following are working:
    - Cross-references between packages, e.g. `rmw` links from `rcl` docs.
    - External references, e.g. references to cppreference.com for `std::string`.
    - References to generated files, e.g. `logging_macros.h` in `rcutils`.
  - Update docs.ros.org to refer to the latest release (index.html, symlink).
