# Decoded PC -> M150 command observed on standard CAN ID 0x172.
# This reports the quantized values that were sent on CAN, not the original
# ROS request. Torque raw values use 0.1% of nominal torque per count.
std_msgs/Header header

uint16 rear_right_speed_limit_rpm
uint16 rear_left_speed_limit_rpm

uint16 rear_right_positive_torque_limit_raw
uint16 rear_right_negative_torque_limit_raw
uint16 rear_left_positive_torque_limit_raw
uint16 rear_left_negative_torque_limit_raw
