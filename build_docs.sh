#!/usr/bin/env bash
set -e

: ${RELEASE_NAME:=dashing}

read -p "Build docs for '${RELEASE_NAME}'? (Yn) " yn
case $yn in
  [Yy]* ) ;;
  [Nn]* ) exit;;
  * ) echo "Please answer yes or no."; exit;;
esac

# Determine package list based on ROS distro
package_names=(
  ament_index_cpp
  ament_index_python
  class_loader
  rcutils
  rcl
  rcl_action
  rcl_lifecycle
  rcl_yaml_param_parser
  rclcpp
  rclcpp_action
  rclcpp_components
  rclcpp_lifecycle
  rclpy
  rmw
  rmw_fastrtps_cpp
  rmw_fastrtps_dynamic_cpp
  rmw_fastrtps_shared_cpp
  tf2
  tf2_eigen
  tf2_geometry_msgs
  tf2_kdl
  tf2_ros
)
# if [[ "eloquent" == "${RELEASE_NAME}" || "foxy" == "${RELEASE_NAME}" ]]; then
  # Packages since Eloquent
  # TODO(jacobperron): Add rcl_logging_spdlog after https://github.com/ros2/rcl_logging/pull/42 is backported and released
  # package_names+=(rcl_logging_spdlog)
# fi
if [[ "foxy" == "${RELEASE_NAME}" ]]; then
  # Packages since Foxy
  package_names+=(
    libstatistics_collector
    rmw_dds_common
    rosidl_runtime_c
    rosidl_runtime_cpp
    tf2_bullet
    tf2_tools
  )
fi

# Setup and build workspace
WSDIR=$(mktemp -d)
cd ${WSDIR}
mkdir src
wget -O ros2.repos https://raw.githubusercontent.com/ros2/ros2/${RELEASE_NAME}-release/ros2.repos
vcs import src < ros2.repos
colcon build --packages-up-to ${package_names[@]}
wget https://raw.githubusercontent.com/ros2/docs.ros2.org/doc_gen/Makefile
wget https://raw.githubusercontent.com/ros2/docs.ros2.org/doc_gen/ros2_doc.repos
vcs import src < ros2_doc.repos

# Update release name in Makefile
sed -i "s/release_name :=.*$/release_name := ${RELEASE_NAME}/" Makefile

# Uncomment Doxyfile lines for generating tag files
sed -i "s/#\s*GENERATE_TAGFILE/GENERATE_TAGFILE/g" $(find src -name Doxyfile)
# Change the ROS 2 TAGFILES links so that they reference docs.ros2.org/<release name> instead of latest
sed -i "s/\(^TAGFILES.*docs\.ros2\.org\/\)latest/\1${RELEASE_NAME}/g" $(find src -name Doxyfile)

# Append "api/" to package names for use in Makefile
for i in "${!package_names[@]}"; do
  package_names[$i]="api/${package_names[$i]}"
done

# Build the docs
make install release_name=${RELEASE_NAME} package_names=${package_names[@]}

echo "Documentation has been generated and copied into '${WSDIR}/src/ros2/docs.ros2.org'."
echo ""
echo "Before commiting:"
echo "  1) Check that cross-references between packages, external references, and references to generated files are working."
echo ""
echo "  2) Update 'index.html' and the 'latest' symlink to refer to the latest release."
