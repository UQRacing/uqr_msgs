# Typed ROS representation of DFMM CAN frames 0x11B/0x11C.
# Current values are raw inverter units because PR 227's DBC does not define
# a physical scale or unit for them.

uint8 LEFT=0
uint8 RIGHT=1

std_msgs/Header header
uint8 side
float32 speed_rad_s
int16 torque_current_raw
int16 magnetizing_current_raw
float32 motor_temperature_c
