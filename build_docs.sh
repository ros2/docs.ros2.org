#!/usr/bin/env bash
set -e

: ${RELEASE_NAME:=dashing}

read -p "Build docs for '${RELEASE_NAME}'? (Yn) " yn
case $yn in
  [Yy]* ) ;;
  [Nn]* ) exit;;
  * ) echo "Please answer yes or no."; exit;;
esac

# Setup and build workspace
WSDIR=$(mktemp -d)
cd ${WSDIR}
mkdir src
wget -O ros2.repos https://raw.githubusercontent.com/ros2/ros2/${RELEASE_NAME}-release/ros2.repos
vcs import src < ros2.repos
git clone https://github.com/ros2/ros2_generate_interface_docs src/ros2_generate_interface_docs
colcon build --packages-up-to ament_index_cpp \
                              ament_index_python \
                              class_loader \
                              geometry2 \
                              libstatistics_collector \
                              rclcpp_action \
                              rclcpp_components \
                              rclcpp_lifecycle \
                              rclpy \
                              ros2_generate_interface_docs \
                              turtlesim
colcon build --packages-select-regex \
                              [a-z_]*_msgs \
                              [a-z]*_srvs \
                              [a-z_]*_interfaces
wget https://raw.githubusercontent.com/ros2/docs.ros2.org/doc_gen/Makefile
wget https://raw.githubusercontent.com/ros2/docs.ros2.org/doc_gen/ros2_doc.repos
vcs import src < ros2_doc.repos

# Update release name in Makefile
sed -i "s/release_name :=.*$/release_name := ${RELEASE_NAME}/" Makefile

# Uncomment Doxyfile lines for generating tag files
sed -i "s/#\s*GENERATE_TAGFILE/GENERATE_TAGFILE/g" $(find src -name Doxyfile)
# Change the ROS 2 TAGFILES links so that they reference docs.ros2.org/<release name> instead of latest
sed -i "s/\(^TAGFILES.*docs\.ros2\.org\/\)latest/\1${RELEASE_NAME}/g" $(find src -name Doxyfile)

# Build the docs
make install

# Build interfaces docs
. install/setup.sh
ros2 run ros2_generate_interface_docs ros2_generate_interface_docs --outputdir ${WSDIR}/api
cp -r ${WSDIR}/api/html/* ${WSDIR}/src/ros2/docs.ros2.org/${RELEASE_NAME}/api

echo "Documentation has been generated and copied into '${WSDIR}/src/ros2/docs.ros2.org'."
echo ""
echo "Before commiting:"
echo "  1) Check that cross-references between packages, external references, and references to generated files are working."
echo ""
echo "  2) Update 'index.html' and the 'latest' symlink to refer to the latest release."
