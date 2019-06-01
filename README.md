## Generating static docs for a ros2 release

  - Update ros2/ros_core_documentation as appropriate; install dependencies mentioned in its readme and Doxygen.
    - Specifically you'll want to update the release name, see: https://github.com/ros2/ros_core_documentation/pull/7
  - Set the name of the release for building docs, for example, "dashing":
    
        export RELEASE_NAME=dashing

  - Run the build script:

        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ros2/docs.ros2.org/doc_gen/build_docs.sh)"

  - Check that the following are working:
      - Cross-references between packages, e.g. `rmw` links from `rcl` docs.
      - External references, e.g. references to cppreference.com for `std::string`.
      - References to generated files, e.g. `logging_macros.h` in `rcutils`.
  - Update docs.ros.org to refer to the latest release (index.html, symlink).
