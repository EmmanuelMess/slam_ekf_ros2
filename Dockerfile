FROM osrf/ros:galactic-desktop

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y \
        ros-${ROS_DISTRO}-turtlebot3* \
        python3-pip \
        python3-tk \
        python3-sklearn && \
    rm -rf /var/lib/apt/lists/*
    
RUN python3 -m pip install easydict

COPY ./slam_ekf /slam_ws/src

WORKDIR /slam_ws

RUN rosdep update && \
    rosdep install --from-paths src -r -y --ignore-src && \
    rm -rf /var/lib/apt/lists/*

