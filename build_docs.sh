#!/usr/bin/env bash
set -e

# Default options
opt_release_name=${ROS_DISTRO:-foxy}
opt_interactive=0
unset opt_repos

print_usage() {
  echo "usage: $0 [-r DISTRO] [-e URL] [-y] [-h] [package [package ...]]"
  echo ""
  echo "  -r DISTRO  Set the name of the ROS distribution (default: ${opt_release_name})"
  echo "             This also determines the version of repositories unless the '-e' option is given."
  echo "  -e URL     Location of a ROS 2 repos file to use instead of a release repos file."
  echo "  -y         Run the script in non-interactive mode"
  echo "  -h         Display this help message"
}

# Path to this file
# Taken from SO post https://stackoverflow.com/a/246128
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

while getopts "r:e:yh" opt; do
  case "${opt}" in
    r)
      opt_release_name=${OPTARG}
      ;;
    e)
      opt_repos=${OPTARG}
      ;;
    y)
      opt_interactive=1
      ;;
    h)
      print_usage
      exit 0
      ;;
    *)
      print_usage
      exit 1
      ;;
  esac
done
shift $((OPTIND-1))

if [ -z ${opt_repos+x} ]; then
  repos_file_url=https://raw.githubusercontent.com/ros2/ros2/${opt_release_name}-release/ros2.repos
else
  repos_file_url=${opt_repos}
fi

if [ $# -gt 0 ]; then
  package_names=$@
else
  # If no packages are provided as arguments, use defaults
  package_names=(
    rcutils
    rcl
    rcl_action
    rcl_yaml_param_parser
    rclcpp
    rclcpp_action
    rclcpp_components
    rclpy
    rmw
  )
  # Append additional default packages for Foxy
  if [[ "foxy" == "${opt_release_name}" ]]; then
    package_names+=(
      ament_index_cpp
      ament_index_python
      class_loader
      libstatistics_collector
      rcl_lifecycle
      # TODO(jacobperron): Add rcl_logging_spdlog after https://github.com/ros2/rcl_logging/pull/42 is released
      # rcl_logging_spdlog
      rclcpp_lifecycle
      rcpputils
      rmw_dds_common
      rmw_fastrtps_cpp
      rmw_fastrtps_dynamic_cpp
      rmw_fastrtps_shared_cpp
      rosidl_runtime_c
      rosidl_runtime_cpp
      tf2
      tf2_bullet
      tf2_eigen
      tf2_geometry_msgs
      tf2_kdl
      tf2_ros
      tf2_tools
    )
  fi
  # Convert bash array to string
  package_names=${package_names[@]}
fi


if [ 0 -eq ${opt_interactive} ]; then
  echo "Building docs with the following configuration:"
  echo "    Release name: ${opt_release_name}"
  echo "    Repos file: ${repos_file_url}"
  echo "    Packages: ${package_names}"
  echo ""
  read -p "Is this correct? (Yn) " yn
  case $yn in
    [Yy]* ) ;;
    [Nn]* ) exit;;
    * ) echo "Please answer yes or no."; exit;;
  esac
fi

# Build code
workspace_dir=$(mktemp -d)
echo "Building workspace in the directory '${workspace_dir}'"
cd ${workspace_dir}
mkdir src
curl -o ros2.repos ${repos_file_url}
vcs import src < ros2.repos
rosdep update
rosdep install --rosdistro ${opt_release_name} --from-paths src -iry
colcon build --packages-up-to ${package_names}

# Clone documentation-specific repos
vcs import src < ${script_dir}/ros2_doc.repos

# Uncomment Doxyfile lines for generating tag files
sed -i "s/#\s*GENERATE_TAGFILE/GENERATE_TAGFILE/g" $(find src -name Doxyfile)
# Change the ROS 2 TAGFILES links so that they reference docs.ros2.org/<release name> instead of latest
sed -i "s/\(^TAGFILES.*docs\.ros2\.org\/\)latest/\1${opt_release_name}/g" $(find src -name Doxyfile)

# Sort packages topologically so that Doxygen tags are available for packages later in order
sorted_packages=$(colcon list --names-only -t --packages-select ${package_names})

# Copy Makefile to current directory
cp ${script_dir}/Makefile .

# Build the docs
make install release_name=${opt_release_name} package_names=${sorted_packages}

echo "Documentation has been generated and copied into '${workspace_dir}/src/ros2/docs.ros2.org'."
echo ""
echo "Before commiting:"
echo "  1) Check that cross-references between packages, external references, and references to generated files are working."
echo ""
echo "  2) Update 'index.html' and the 'latest' symlink to refer to the latest release."
