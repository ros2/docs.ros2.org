## Generating static API documentation for a ROS 2 release

  - Update ros2/ros_core_documentation as appropriate; install dependencies mentioned in its readme and Doxygen.
    - Specifically you'll want to update the release name, see: https://github.com/ros2/ros_core_documentation/pull/7

  - Clone this repo and checkout the `doc_gen` branch:

        git clone https://github.com/docs.ros2.org.git -b doc_gen

  - Run the build script using the `-r` option to select the release codename:

        docs.ros2.org/build_docs.sh -r foxy

  - Check that the following are working:
      - Cross-references between packages, e.g. `rmw` links from `rcl` docs.
      - External references, e.g. references to cppreference.com for `std::string`.
      - References to generated files, e.g. `logging_macros.h` in `rcutils`.
  - Update docs.ros.org to refer to the latest release (index.html, symlink).
