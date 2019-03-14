## Generating static docs for a ros2 release

  - Build up to `rclcpp_action` and `rclpy` in a clean ros2 workspace.
    - e.g. `colcon build --packages-up-to rclcpp_action rclpy`
  - Download the Makefile to the base of that workspace or apply `-f PATH/TO/Makefile` to all `make` invocations below.
  - Update the release name in the Makefile.
  - Import the documentation repos into the workspace with `vcs import src < ros2_doc.repos`
  - Update ros2/ros_core_documentation as appropriate; install dependencies mentioned in its readme and Doxygen.
    - Specifically you'll want to update the release name, see: https://github.com/ros2/ros_core_documentation/pull/7
  - Update the Doxyfile of all packages listed in the Makefile:
    - Uncomment the relevant line so that they will generate tag files.

            sed -i 's/#\s*GENERATE_TAGFILE/GENERATE_TAGFILE/g' $(find src -name Doxyfile)

    - Change the ROS 2 `TAGFILES` links so that they reference `docs.ros2.org/<release name>` instead of `latest`.

            sed -i 's/\(^TAGFILES.*docs\.ros2\.org\/\)latest/\1crystal/g' $(find src -name Doxyfile)

  - Run `make install` from the base of the workspace.
    This will build documented repositories in place to support generated code and then generate and copy the docs into `src/ros2/docs.ros2.org/<release_name>`.
  - Check that the following are working:
    - Cross-references between packages, e.g. `rmw` links from `rcl` docs.
    - External references, e.g. references to cppreference.com for `std::string`.
    - References to generated files, e.g. `logging_macros.h` in `rcutils`.
  - Update docs.ros.org to refer to the latest release (index.html, symlink).
