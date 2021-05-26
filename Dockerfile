FROM osrf/ros:melodic-desktop-full-bionic

# Install dependencies
RUN apt-get update && apt-get install -y \
    ros-melodic-turtlebot3 \
    ros-melodic-turtlebot3-simulations \
    ros-melodic-cartographer \
    ros-melodic-cartographer-ros \
    ros-melodic-octomap \
    ros-melodic-octomap-server \

# Setup ROS environment
RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc && \
    mkdir -p ~/catkin_ws/src

# Copy source files
WORKDIR /root/catkin_ws/src
COPY ./src ./velodyne_slam_simulation

# Build
WORKDIR /root/catkin_ws
RUN /bin/bash -c '. /opt/ros/melodic/setup.bash; catkin_make' && \
    echo "source /root/catkin_ws/devel/setup.bash" >> ~/.bashrc
