#!/bin/bash

set -e

# Provides the 'check' and 'reportResults' commands.
source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.
check "ros2 installed" bash -c "ros2 pkg list | grep 'ros_core'"
# Should default to humble
check "ros2 env" bash -c "echo $ROS_DISTRO | grep 'humble'"

# Report results
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
