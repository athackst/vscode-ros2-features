#!/bin/sh
set -e

echo "Activating feature 'ROS2'"

DISTRO=${DISTRO:-undefined}
echo "The ROS2 distro is: $DISTRO"

# The 'install.sh' entrypoint script is always executed as the root user.

export DEBIAN_FRONTEND=noninteractive

# Set locale
apt-get update && apt-get install -y locales
locale-gen en_US en_US.UTF-8
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

# Add the ROS2 apt-get repository
apt-get install -y software-properties-common
add-apt-repository universe

# Add the ROS2 GPG key
apt-get update && apt-get install -y curl
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

# Add the repository to your sources list
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Install development tools and ROS tools
apt-get update
apt-get install -y ros-${DISTRO}-${PACKAGE} ros-dev-tools python3-argcomplete

echo "source /opt/ros/${DISTRO}/setup.bash" >> $_REMOTE_USER_HOME/.bashrc

export DEBIAN_FRONTEND=
