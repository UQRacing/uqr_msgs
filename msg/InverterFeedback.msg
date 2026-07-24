# Typed ROS representation of DFMM CAN frames 0x11D/0x11E.

uint8 LEFT=0
uint8 RIGHT=1

std_msgs/Header header
uint8 side
uint16 status_word
uint16 diagnostic_number
float32 inverter_temperature_c
float32 igbt_temperature_c
uint8 state
uint8 boot_state
bool actual_values_1_valid
bool actual_values_2_valid
