# This file contains the data for a depth image for processing in the perception stack

std_msgs/Header header
# PNG compressed depth image
sensor_msgs/CompressedImage depth_image
# Distance in metres that a pixel value of 0 corresponds to
float64 min
# Distance in metres that a pixel value of 255 corresponds to
float64 max
