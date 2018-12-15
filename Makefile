release_name := ardent

default: $(release_name) api/rcutils api/rmw api api/rcl api/rclcpp

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

api/rclcpp: src/ros2/rclcpp/rclcpp/doc_output/html
	rm -r api/rclcpp || true
	test -d api || mkdir api
	cp -r $< $@

src/ros2/ros_core_documentation/build/html: src/ros2/ros_core_documentation/Makefile
	rm -r $@ || true
	cd src/ros2/ros_core_documentation && make html

src/ros2/rcutils/doc_output/html doxygen_tag_files/rcutils.tag: src/ros2/rcutils/Doxyfile
	rm -r $@ || true
	rm doxygen_tag_files/rcutils.tag || true
	cd src/ros2/rcutils && doxygen Doxyfile

src/ros2/rmw/rmw/doc_output/html doxygen_tag_files/rmw.tag: src/ros2/rmw/rmw/Doxyfile doxygen_tag_files/rcutils.tag
	rm -r doc_output || true
	rm doxygen_tag_files/rmw.tag || true
	cd src/ros2/rmw/rmw && doxygen Doxyfile

src/ros2/rcl/rcl/doc_output/html doxygen_tag_files/rcl.tag: src/ros2/rcl/rcl/Doxyfile doxygen_tag_files/rcutils.tag doxygen_tag_files/rmw.tag
	rm -r doc_output || true
	rm doxygen_tag_files/rcl.tag || true
	cd src/ros2/rcl/rcl && doxygen Doxyfile

src/ros2/rclcpp/rclcpp/doc_output/html doxygen_tag_files/rclcpp.tag: src/ros2/rclcpp/rclcpp/Doxyfile doxygen_tag_files/rcl.tag doxygen_tag_files/rmw.tag doxygen_tag_files/rcutils.tag
	rm -r doc_output || true
	rm doxygen_tag_files/rclcpp.tag || true
	cd src/ros2/rclcpp/rclcpp && doxygen Doxyfile

cpp-doxygen-web.tag.xml:
	test -d doxygen_tag_files || mkdir doxygen_tag_files
	wget 'http://upload.cppreference.com/mwiki/images/f/f8/cppreference-doxygen-web.tag.xml' \
		-O doxygen_tag_files/cppreference-doxygen-web.tag.xml

setup: cpp-doxygen-web.tag.xml
