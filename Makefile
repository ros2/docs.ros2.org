api_directory_name ?= api

default: setup $(release_name) $(package_names)

install: default
	rm -r src/ros2/docs.ros2.org/$(release_name) || true
	cp -r $(release_name) src/ros2/docs.ros2.org/$(release_name)
	cp -r $(api_directory_name) src/ros2/docs.ros2.org/$(release_name)/$(api_directory_name)

clean:
	rm -r $(release_name) $(api_directory_name) || true

purge:
	rm -r src/ros2/**/doc_output src/ros2/ros_core_documentation/build src/ros2/rclpy/rclpy/docs/build || true

$(release_name): src/ros2/ros_core_documentation/build/html
	rm -r $@ || true
	cp -r $< $@

ament_index_cpp: src/ament/ament_index/ament_index_cpp/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

ament_index_python: src/ament/ament_index/ament_index_python/docs/build/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

class_loader: src/ros/class_loader/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

console_bridge_vendor: src/ros2/console_bridge_vendor/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

libstatistics_collector: src/ros-tooling/libstatistics_collector/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

rcutils: src/ros2/rcutils/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

rcpputils: src/ros2/rcpputils/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

rmw: src/ros2/rmw/rmw/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

rmw_dds_common: src/ros2/rmw_dds_common/rmw_dds_common/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

rcl: src/ros2/rcl/rcl/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

rcl_action: src/ros2/rcl/rcl_action/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

rcl_lifecycle: src/ros2/rcl/rcl_lifecycle/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

rcl_logging_spdlog: src/ros2/rcl_logging/rcl_logging_spdlog/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

rcl_yaml_param_parser: src/ros2/rcl/rcl_yaml_param_parser/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

rclcpp: src/ros2/rclcpp/rclcpp/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

rclcpp_action: src/ros2/rclcpp/rclcpp_action/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

rclcpp_components: src/ros2/rclcpp/rclcpp_components/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

rclcpp_lifecycle: src/ros2/rclcpp/rclcpp_lifecycle/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

rclpy: src/ros2/rclpy/rclpy/docs/build/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

rosidl_runtime_c: src/ros2/rosidl/rosidl_runtime_c/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

rosidl_runtime_cpp: src/ros2/rosidl/rosidl_runtime_cpp/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

rosidl_typesupport_c: src/ros2/rosidl_typesupport/rosidl_typesupport_c/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

rosidl_typesupport_cpp: src/ros2/rosidl_typesupport/rosidl_typesupport_cpp/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

rosidl_typesupport_fastrtps_c: src/ros2/rosidl_typesupport_fastrtps/rosidl_typesupport_fastrtps_c/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

rosidl_typesupport_fastrtps_cpp: src/ros2/rosidl_typesupport_fastrtps/rosidl_typesupport_fastrtps_cpp/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

rosidl_typesupport_interface: src/ros2/rosidl/rosidl_typesupport_interface/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

rmw_fastrtps_cpp: src/ros2/rmw_fastrtps/rmw_fastrtps_cpp/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

rmw_fastrtps_dynamic_cpp: src/ros2/rmw_fastrtps/rmw_fastrtps_dynamic_cpp/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

rmw_fastrtps_shared_cpp: src/ros2/rmw_fastrtps/rmw_fastrtps_shared_cpp/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

tf2: src/ros2/geometry2/tf2/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

tf2_bullet: src/ros2/geometry2/tf2_bullet/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

tf2_eigen: src/ros2/geometry2/tf2_eigen/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

tf2_geometry_msgs: src/ros2/geometry2/tf2_geometry_msgs/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

tf2_kdl: src/ros2/geometry2/tf2_kdl/docs/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

tf2_ros: src/ros2/geometry2/tf2_ros/docs/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

tf2_tools: src/ros2/geometry2/tf2_tools/doc_output/html
	rm -r $(api_directory_name)/$@ || true
	cp -r $< $(api_directory_name)/$@

src/ros2/ros_core_documentation/build/html: src/ros2/ros_core_documentation/Makefile
	rm -r $@ || true
	cd src/ros2/ros_core_documentation && make html

src/ament/ament_index/ament_index_cpp/doc_output/html doxygen_tag_files/ament_index_cpp.tag: src/ament/ament_index/ament_index_cpp/Doxyfile
	. install/setup.sh && \
		cd src/ament/ament_index/ament_index_cpp && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/ament_index_cpp.tag || true
	cd  src/ament/ament_index/ament_index_cpp/ && doxygen Doxyfile

src/ament/ament_index/ament_index_python/docs/build/html doxygen_tag_files/ament_index_python.tag: src/ros2/rcutils/Doxyfile
	rm -r $@ || true
	cd src/ament/ament_index/ament_index_python/docs/ && \
	 \
		git clean -dfx && \
		make html

src/ros/class_loader/doc_output/html doxygen_tag_files/class_loader.tag: src/ros/class_loader/Doxyfile
	. install/setup.sh && \
		cd src/ros/class_loader && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/class_loader.tag || true
	cd src/ros/class_loader && doxygen Doxyfile

src/ros2/console_bridge_vendor/doc_output/html doxygen_tag_files/console_bridge.tag: src/ros2/console_bridge_vendor//Doxyfile
	. install/setup.sh && \
		cd src/ros/console_bridge && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/console_bridge.tag || true
	cd build/console_bridge_vendor/console_bridge-*-prefix/src/ \
	version=`ls *.tar.gz | awk '{print $1}' | rev | cut -f 3- -d '.' | rev` \
	cd console_bridge-${version} && doxygen Doxyfile

src/ros-tooling/libstatistics_collector/doc_output/html doxygen_tag_files/libstatistics_collector.tag: src/ros-tooling/libstatistics_collector/Doxyfile
	. install/setup.sh && \
		cd src/ros-tooling/libstatistics_collector && \
		git clean -dfx && \
	  cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/libstatistics_collector.tag || true
	cd  src/ros-tooling/libstatistics_collector && doxygen Doxyfile

src/ros2/rcutils/doc_output/html doxygen_tag_files/rcutils.tag: src/ros2/rcutils/Doxyfile
	. install/setup.sh && \
		cd src/ros2/rcutils && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/rcutils.tag || true
	cd src/ros2/rcutils && doxygen Doxyfile

src/ros2/rcpputils/doc_output/html doxygen_tag_files/rcpputils.tag: src/ros2/rcpputils/Doxyfile
	. install/setup.sh && \
		cd src/ros2/rcpputils && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/rcpputils.tag || true
	cd src/ros2/rcpputils && doxygen Doxyfile

src/ros2/rmw/rmw/doc_output/html doxygen_tag_files/rmw.tag: src/ros2/rmw/rmw/Doxyfile
	. install/setup.sh && \
		cd src/ros2/rmw/rmw && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/rmw.tag || true
	cd src/ros2/rmw/rmw && doxygen Doxyfile

src/ros2/rmw_dds_common/rmw_dds_common/doc_output/html doxygen_tag_files/rmw_dds_common.tag:
	. install/setup.sh && \
		cd src/ros2/rmw_dds_common/rmw_dds_common && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/rmw_dds_common.tag || true
	cd src/ros2/rmw_dds_common/rmw_dds_common && doxygen Doxyfile

src/ros2/rcl/rcl/doc_output/html doxygen_tag_files/rcl.tag: src/ros2/rcl/rcl/Doxyfile
	. install/setup.sh && \
		cd src/ros2/rcl/rcl && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/rcl.tag || true
	cd src/ros2/rcl/rcl && doxygen Doxyfile

src/ros2/rcl/rcl_action/doc_output/html doxygen_tag_files/rcl_action.tag: src/ros2/rcl/rcl_action/Doxyfile
	. install/setup.sh && \
		cd src/ros2/rcl/rcl_action && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/rcl_action.tag || true
	cd src/ros2/rcl/rcl_action && doxygen Doxyfile

src/ros2/rcl/rcl_lifecycle/doc_output/html doxygen_tag_files/rcl_lifecycle.tag: src/ros2/rcl/rcl_lifecycle/Doxyfile
	. install/setup.sh && \
		cd src/ros2/rcl/rcl_lifecycle && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/rcl_lifecycle.tag || true
	cd src/ros2/rcl/rcl_lifecycle && doxygen Doxyfile

src/ros2/rcl_logging/rcl_logging_spdlog/doc_output/html doxygen_tag_files/rcl_logging_spdlog.tag: src/ros2/rcl_logging/rcl_logging_spdlog/Doxyfile
	. install/setup.sh && \
		cd src/ros2/rcl_logging/rcl_logging_spdlog && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/rcl_logging_spdlog.tag || true
	cd src/ros2/rcl_logging/rcl_logging_spdlog && doxygen Doxyfile

src/ros2/rcl/rcl_yaml_param_parser/doc_output/html doxygen_tag_files/rcl_yaml_param_parser.tag: src/ros2/rcl/rcl_yaml_param_parser/Doxyfile
	. install/setup.sh && \
		cd src/ros2/rcl/rcl_yaml_param_parser && \
		git clean -dfx && \
		cmake . && make -j 8
	rm -r $@ || true
	rm doxygen_tag_files/rcl_yaml_param_parser.tag || true
	cd src/ros2/rcl/rcl_yaml_param_parser && doxygen Doxyfile

src/ros2/rclcpp/rclcpp/doc_output/html doxygen_tag_files/rclcpp.tag: src/ros2/rclcpp/rclcpp/Doxyfile
	. install/setup.sh && \
		cd src/ros2/rclcpp/rclcpp && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/rclcpp.tag || true
	cd src/ros2/rclcpp/rclcpp && doxygen Doxyfile

src/ros2/rclcpp/rclcpp_action/doc_output/html doxygen_tag_files/rclcpp_action.tag: src/ros2/rclcpp/rclcpp_action/Doxyfile
	. install/setup.sh && \
		cd src/ros2/rclcpp/rclcpp_action && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/rclcpp_action.tag || true
	cd src/ros2/rclcpp/rclcpp_action && doxygen Doxyfile

src/ros2/rclcpp/rclcpp_components/doc_output/html doxygen_tag_files/rclcpp_components.tag: src/ros2/rclcpp/rclcpp_components/Doxyfile
	. install/setup.sh && \
		cd src/ros2/rclcpp/rclcpp_components && \
		git clean -dfx && \
		cmake . && make -j 8
	rm -r $@ || true
	rm doxygen_tag_files/rclcpp_components.tag || true
	cd src/ros2/rclcpp/rclcpp_components && doxygen Doxyfile

src/ros2/rclcpp/rclcpp_lifecycle/doc_output/html doxygen_tag_files/rclcpp_lifecycle.tag: src/ros2/rclcpp/rclcpp_lifecycle/Doxyfile
	. install/setup.sh && \
		cd src/ros2/rclcpp/rclcpp_lifecycle && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/rclcpp_lifecycle.tag || true
	cd src/ros2/rclcpp/rclcpp_lifecycle && doxygen Doxyfile

src/ros2/rclpy/rclpy/docs/build/html:
	rm -r $@ || true
	. install/setup.sh && \
	    cd src/ros2/rclpy/rclpy/docs && \
		git clean -dfx && \
		make html

src/ros2/rmw_fastrtps/rmw_fastrtps_cpp/doc_output/html:
	. install/setup.sh && \
		cd src/ros2/rmw_fastrtps/rmw_fastrtps_cpp && \
		git clean -dfx && \
		cmake . && make -j 8
	rm -r $@ || true
	rm doxygen_tag_files/rmw_fastrtps_cpp.tag || true
	cd src/ros2/rmw_fastrtps/rmw_fastrtps_cpp && doxygen Doxyfile

src/ros2/rmw_fastrtps/rmw_fastrtps_dynamic_cpp/doc_output/html:
	. install/setup.sh && \
		cd src/ros2/rmw_fastrtps/rmw_fastrtps_dynamic_cpp && \
		git clean -dfx && \
		cmake . && make -j 8
	rm -r $@ || true
	rm doxygen_tag_files/rmw_fastrtps_dynamic_cpp.tag || true
	cd src/ros2/rmw_fastrtps/rmw_fastrtps_dynamic_cpp && doxygen Doxyfile

src/ros2/rmw_fastrtps/rmw_fastrtps_shared_cpp/doc_output/html:
	. install/setup.sh && \
		cd src/ros2/rmw_fastrtps/rmw_fastrtps_shared_cpp && \
		git clean -dfx && \
		cmake . && make -j 8
	rm -r $@ || true
	rm doxygen_tag_files/rmw_fastrtps_shared_cpp.tag || true
	cd src/ros2/rmw_fastrtps/rmw_fastrtps_shared_cpp && doxygen Doxyfile

src/ros2/rosidl/rosidl_runtime_c/doc_output/html:
	. install/setup.sh && \
		cd src/ros2/rosidl/rosidl_runtime_c && \
		git clean -dfx && \
		cmake . && make -j 8
	rm -r $@ || true
	rm doxygen_tag_files/rosidl_runtime_c.tag || true
	cd src/ros2/rosidl/rosidl_runtime_c && doxygen Doxyfile

src/ros2/rosidl/rosidl_runtime_cpp/doc_output/html:
	. install/setup.sh && \
		cd src/ros2/rosidl/rosidl_runtime_cpp && \
		git clean -dfx && \
		cmake . && make -j 8
	rm -r $@ || true
	rm doxygen_tag_files/rosidl_runtime_cpp.tag || true
	cd src/ros2/rosidl/rosidl_runtime_cpp && doxygen Doxyfile

src/ros2/rosidl/rosidl_typesupport_interface/doc_output/html:
	. install/setup.sh && \
		cd src/ros2/rosidl/rosidl_typesupport_interface && \
		git clean -dfx && \
		cmake . && make -j 8
	rm -r $@ || true
	rm doxygen_tag_files/rosidl_typesupport_interface.tag || true
	cd src/ros2/rosidl/rosidl_typesupport_interface && doxygen Doxyfile

src/ros2/rosidl_typesupport/rosidl_typesupport_c/doc_output/html:
	. install/setup.sh && \
		cd src/ros2/rosidl_typesupport/rosidl_typesupport_c && \
		git clean -dfx && \
		cmake . && make -j 8
	rm -r $@ || true
	rm doxygen_tag_files/rosidl_typesupport_c.tag || true
	cd src/ros2/rosidl_typesupport/rosidl_typesupport_c && doxygen Doxyfile

src/ros2/rosidl_typesupport/rosidl_typesupport_cpp/doc_output/html:
	. install/setup.sh && \
		cd src/ros2/rosidl_typesupport/rosidl_typesupport_cpp && \
		git clean -dfx && \
		cmake . && make -j 8
	rm -r $@ || true
	rm doxygen_tag_files/rosidl_typesupport_cpp.tag || true
	cd src/ros2/rosidl_typesupport/rosidl_typesupport_cpp && doxygen Doxyfile

src/ros2/rosidl_typesupport_fastrtps/rosidl_typesupport_fastrtps_c/doc_output/html:
	. install/setup.sh && \
		cd src/ros2/rosidl_typesupport_fastrtps/rosidl_typesupport_fastrtps_c && \
		git clean -dfx && \
		cmake . && make -j 8
	rm -r $@ || true
	rm doxygen_tag_files/rosidl_typesupport_fastrtps_c.tag || true
	cd src/ros2/rosidl_typesupport_fastrtps/rosidl_typesupport_fastrtps_c && doxygen Doxyfile

src/ros2/rosidl_typesupport_fastrtps/rosidl_typesupport_fastrtps_cpp/doc_output/html:
	. install/setup.sh && \
		cd src/ros2/rosidl_typesupport_fastrtps/rosidl_typesupport_fastrtps_cpp && \
		git clean -dfx && \
		cmake . && make -j 8
	rm -r $@ || true
	rm doxygen_tag_files/rosidl_typesupport_fastrtps_cpp.tag || true
	cd src/ros2/rosidl_typesupport_fastrtps/rosidl_typesupport_fastrtps_cpp && doxygen Doxyfile

src/ros2/geometry2/tf2/doc_output/html:
	. install/setup.sh && \
		cd src/ros2/geometry2/tf2/ && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/tf2.tag || true
	cd src/ros2/geometry2/tf2 && doxygen Doxyfile

src/ros2/geometry2/tf2_bullet/doc_output/html:
	. install/setup.sh && \
		cd src/ros2/geometry2/tf2_bullet/ && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/tf2_bullet.tag || true
	cd src/ros2/geometry2/tf2_bullet && doxygen Doxyfile

src/ros2/geometry2/tf2_eigen/doc_output/html:
	. install/setup.sh && \
		cd src/ros2/geometry2/tf2_eigen/ && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/tf2_eigen.tag || true
	cd src/ros2/geometry2/tf2_eigen && doxygen Doxyfile

src/ros2/geometry2/tf2_geometry_msgs/doc_output/html:
	. install/setup.sh && \
		cd src/ros2/geometry2/tf2_geometry_msgs/ && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/tf2_geometry_msgs.tag || true
	cd src/ros2/geometry2/tf2_geometry_msgs && doxygen Doxyfile

src/ros2/geometry2/tf2_kdl/docs/doc_output/html:
	. install/setup.sh && \
		cd src/ros2/geometry2/tf2_kdl && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/tf2_kdl.tag || true
	cd src/ros2/geometry2/tf2_kdl/docs && doxygen Doxyfile

src/ros2/geometry2/tf2_ros/docs/doc_output/html:
	. install/setup.sh && \
		cd src/ros2/geometry2/tf2_ros && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/tf2_ros.tag || true
	cd src/ros2/geometry2/tf2_ros/docs && doxygen Doxyfile

src/ros2/geometry2/tf2_tools/doc_output/html:
	. install/setup.sh && \
		cd src/ros2/geometry2/tf2_tools/ && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/tf2_tools.tag || true
	cd src/ros2/geometry2/tf2_tools && doxygen Doxyfile

cpp-doxygen-web.tag.xml:
	test -d doxygen_tag_files || mkdir doxygen_tag_files
	wget 'http://upload.cppreference.com/mwiki/images/f/f8/cppreference-doxygen-web.tag.xml' \
		-O doxygen_tag_files/cppreference-doxygen-web.tag.xml

setup: cpp-doxygen-web.tag.xml
	test -d $(api_directory_name) || mkdir $(api_directory_name)
