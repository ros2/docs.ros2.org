release_name := crystal

default: setup $(release_name) \
	api \
	api/rcutils \
	api/rcpputils \
	api/rcl \
	api/rcl_action \
	api/rcl_lifecycle \
	api/rclcpp \
	api/rclcpp_action \
	api/rclcpp_lifecycle \
	api/rclpy \
	api/rosidl_runtime_c \
  api/rosidl_runtime_cpp \
	api/rmw \

install: default
	rm -r src/ros2/docs.ros2.org/$(release_name) || true
	cp -r $(release_name) src/ros2/docs.ros2.org/$(release_name)
	cp -r api src/ros2/docs.ros2.org/$(release_name)/api


clean:
	rm -r $(release_name) api || true

purge:
	rm -r src/ros2/**/doc_output src/ros2/ros_core_documentation/build src/ros2/rclpy/rclpy/docs/build || true

$(release_name): src/ros2/ros_core_documentation/build/html
	rm -r $@ || true
	cp -r $< $@

api/rcutils: src/ros2/rcutils/doc_output/html
	rm -r $@ || true
	test -d api || mkdir api
	cp -r $< $@

api/rcpputils: src/ros2/rcpputils/doc_output/html
	rm -r $@ || true
	test -d api || mkdir api
	cp -r $< $@

api/rmw: src/ros2/rmw/rmw/doc_output/html
	rm -r $@ || true
	test -d api || mkdir api
	cp -r $< $@

api/rcl: src/ros2/rcl/rcl/doc_output/html
	rm -r $@ || true
	test -d api || mkdir api
	cp -r $< $@

api/rcl_action: src/ros2/rcl/rcl_action/doc_output/html
	rm -r $@ || true
	test -d api || mkdir api
	cp -r $< $@

api/rcl_lifecycle: src/ros2/rcl/rcl_lifecycle/doc_output/html
	rm -r $@ || true
	test -d api || mkdir api
	cp -r $< $@

api/rclcpp: src/ros2/rclcpp/rclcpp/doc_output/html
	rm -r $@ || true
	test -d api || mkdir api
	cp -r $< $@

api/rclcpp_action: src/ros2/rclcpp/rclcpp_action/doc_output/html
	rm -r $@ || true
	test -d api || mkdir api
	cp -r $< $@

api/rclcpp_lifecycle: src/ros2/rclcpp/rclcpp_lifecycle/doc_output/html
	rm -r $@ || true
	test -d api || mkdir api
	cp -r $< $@

api/rclpy: src/ros2/rclpy/rclpy/docs/build/html
	rm -r $@ || true
	test -d api || mkdir api
	cp -r $< $@

api/rosidl_runtime_c: src/ros2/rosidl/rosidl_runtime_c/doc_output/html
	rm -r $@ || true
	test -d api || mkdir api
	cp -r $< $@

api/rosidl_runtime_cpp: src/ros2/rosidl/rosidl_runtime_cpp/doc_output/html
	rm -r $@ || true
	test -d api || mkdir api
	cp -r $< $@

src/ros2/ros_core_documentation/build/html: src/ros2/ros_core_documentation/Makefile
	rm -r $@ || true
	cd src/ros2/ros_core_documentation && make html

src/ros2/rcutils/doc_output/html doxygen_tag_files/rcutils.tag: src/ros2/rcutils/Doxyfile
	. install/setup.sh && \
		cd src/ros2/rcutils && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/rcutils.tag || true
	cd src/ros2/rcutils && doxygen Doxyfile

src/ros2/rcpputils/doc_output/html doxygen_tag_files/rcpputils.tag: src/ros2/rcpputils/Doxyfile doxygen_tag_files/rcutils.tag
	. install/setup.sh && \
		cd src/ros2/rcpputils && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/rcpputils.tag || true
	cd src/ros2/rcpputils && doxygen Doxyfile

src/ros2/rmw/rmw/doc_output/html doxygen_tag_files/rmw.tag: src/ros2/rmw/rmw/Doxyfile doxygen_tag_files/rcutils.tag doxygen_tag_files/rcpputils.tag
	. install/setup.sh && \
		cd src/ros2/rmw/rmw && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/rmw.tag || true
	cd src/ros2/rmw/rmw && doxygen Doxyfile

src/ros2/rcl/rcl/doc_output/html doxygen_tag_files/rcl.tag: src/ros2/rcl/rcl/Doxyfile doxygen_tag_files/rcutils.tag doxygen_tag_files/rcpputils.tag doxygen_tag_files/rmw.tag
	. install/setup.sh && \
		cd src/ros2/rcl/rcl && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/rcl.tag || true
	cd src/ros2/rcl/rcl && doxygen Doxyfile

src/ros2/rcl/rcl_action/doc_output/html doxygen_tag_files/rcl_action.tag: src/ros2/rcl/rcl_action/Doxyfile doxygen_tag_files/rcutils.tag doxygen_tag_files/rcpputils.tag doxygen_tag_files/rmw.tag doxygen_tag_files/rcl.tag
	. install/setup.sh && \
		cd src/ros2/rcl/rcl_action && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/rcl_action.tag || true
	cd src/ros2/rcl/rcl_action && doxygen Doxyfile

src/ros2/rcl/rcl_lifecycle/doc_output/html doxygen_tag_files/rcl_lifecycle.tag: src/ros2/rcl/rcl_lifecycle/Doxyfile doxygen_tag_files/rcutils.tag doxygen_tag_files/rcpputils.tag doxygen_tag_files/rmw.tag doxygen_tag_files/rcl.tag
	. install/setup.sh && \
		cd src/ros2/rcl/rcl_lifecycle && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/rcl_lifecycle.tag || true
	cd src/ros2/rcl/rcl_lifecycle && doxygen Doxyfile

src/ros2/rclcpp/rclcpp/doc_output/html doxygen_tag_files/rclcpp.tag: src/ros2/rclcpp/rclcpp/Doxyfile doxygen_tag_files/rcl.tag doxygen_tag_files/rcpputils.tag doxygen_tag_files/rmw.tag doxygen_tag_files/rcutils.tag
	. install/setup.sh && \
		cd src/ros2/rclcpp/rclcpp && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/rclcpp.tag || true
	cd src/ros2/rclcpp/rclcpp && doxygen Doxyfile

src/ros2/rclcpp/rclcpp_action/doc_output/html doxygen_tag_files/rclcpp_action.tag: src/ros2/rclcpp/rclcpp_action/Doxyfile doxygen_tag_files/rclcpp.tag doxygen_tag_files/rcl.tag doxygen_tag_files/rmw.tag doxygen_tag_files/rcutils.tag  doxygen_tag_files/rcpputils.tag
	. install/setup.sh && \
		cd src/ros2/rclcpp/rclcpp_action && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/rclcpp_action.tag || true
	cd src/ros2/rclcpp/rclcpp_action && doxygen Doxyfile

src/ros2/rclcpp/rclcpp_lifecycle/doc_output/html doxygen_tag_files/rclcpp_lifecycle.tag: src/ros2/rclcpp/rclcpp_lifecycle/Doxyfile doxygen_tag_files/rclcpp.tag doxygen_tag_files/rcl.tag doxygen_tag_files/rmw.tag doxygen_tag_files/rcutils.tag  doxygen_tag_files/rcpputils.tag
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

cpp-doxygen-web.tag.xml:
	test -d doxygen_tag_files || mkdir doxygen_tag_files
	wget 'http://upload.cppreference.com/mwiki/images/f/f8/cppreference-doxygen-web.tag.xml' \
		-O doxygen_tag_files/cppreference-doxygen-web.tag.xml

setup: cpp-doxygen-web.tag.xml
