# This file contains a target steering wheel angle and speed for the car to run
# It's the high level actuation message

std_msgs/Header header
float64 steering_angle # target steering wheel angle in radians
float64 speed # target speed in m/s
