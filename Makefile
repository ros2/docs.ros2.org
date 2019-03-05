release_name := crystal

default: $(release_name) api/rcutils api/rmw api api/rcl api/rcl_action api/rclcpp api/rclcpp_action api/rclpy

install: default
	rm -r src/ros2/docs.ros2.org/$(release_name) || true
	cp -r $(release_name) src/ros2/docs.ros2.org/$(release_name)
	cp -r api src/ros2/docs.ros2.org/$(release_name)/api


clean:
	rm -r $(release_name) api || true

purge:
	rm -r src/ros2/**/doc_output src/ros2/ros_core_documentation/build || true

$(release_name): src/ros2/ros_core_documentation/build/html
	rm -r $@ || true
	cp -r $< $@

api/rcutils: src/ros2/rcutils/doc_output/html
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

api/rclcpp: src/ros2/rclcpp/rclcpp/doc_output/html
	rm -r $@ || true
	test -d api || mkdir api
	cp -r $< $@

api/rclcpp_action: src/ros2/rclcpp/rclcpp_action/doc_output/html
	rm -r $@ || true
	test -d api || mkdir api
	cp -r $< $@

api/rclpy: src/ros2/rclpy/rclpy/docs/build/html
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

src/ros2/rmw/rmw/doc_output/html doxygen_tag_files/rmw.tag: src/ros2/rmw/rmw/Doxyfile doxygen_tag_files/rcutils.tag
	. install/setup.sh && \
		cd src/ros2/rmw/rmw && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/rmw.tag || true
	cd src/ros2/rmw/rmw && doxygen Doxyfile

src/ros2/rcl/rcl/doc_output/html doxygen_tag_files/rcl.tag: src/ros2/rcl/rcl/Doxyfile doxygen_tag_files/rcutils.tag doxygen_tag_files/rmw.tag
	. install/setup.sh && \
		cd src/ros2/rcl/rcl && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/rcl.tag || true
	cd src/ros2/rcl/rcl && doxygen Doxyfile

src/ros2/rcl/rcl_action/doc_output/html doxygen_tag_files/rcl_action.tag: src/ros2/rcl/rcl_action/Doxyfile doxygen_tag_files/rcutils.tag doxygen_tag_files/rmw.tag doxygen_tag_files/rcl.tag
	. install/setup.sh && \
		cd src/ros2/rcl/rcl_action && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/rcl_action.tag || true
	cd src/ros2/rcl/rcl_action && doxygen Doxyfile

src/ros2/rclcpp/rclcpp/doc_output/html doxygen_tag_files/rclcpp.tag: src/ros2/rclcpp/rclcpp/Doxyfile doxygen_tag_files/rcl.tag doxygen_tag_files/rmw.tag doxygen_tag_files/rcutils.tag
	. install/setup.sh && \
		cd src/ros2/rclcpp/rclcpp && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/rclcpp.tag || true
	cd src/ros2/rclcpp/rclcpp && doxygen Doxyfile

src/ros2/rclcpp/rclcpp_action/doc_output/html doxygen_tag_files/rclcpp_action.tag: src/ros2/rclcpp/rclcpp_action/Doxyfile doxygen_tag_files/rclcpp.tag doxygen_tag_files/rcl.tag doxygen_tag_files/rmw.tag doxygen_tag_files/rcutils.tag
	. install/setup.sh && \
		cd src/ros2/rclcpp/rclcpp_action && \
		git clean -dfx && \
		cmake . && make
	rm -r $@ || true
	rm doxygen_tag_files/rclcpp_action.tag || true
	cd src/ros2/rclcpp/rclcpp_action && doxygen Doxyfile

src/ros2/rclpy/rclpy/docs/build/html:
	rm -r $@ || true
	. install/setup.sh && \
	    cd src/ros2/rclpy/rclpy/docs && \
		git clean -dfx && \
		make html

cpp-doxygen-web.tag.xml:
	test -d doxygen_tag_files || mkdir doxygen_tag_files
	wget 'http://upload.cppreference.com/mwiki/images/f/f8/cppreference-doxygen-web.tag.xml' \
		-O doxygen_tag_files/cppreference-doxygen-web.tag.xml

setup: cpp-doxygen-web.tag.xml