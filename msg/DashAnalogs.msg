# Dash analog inputs: throttle sensors (CAN 0x3F8 main / 0x3F9 tracking)
# and the front brake pressure sensor voltage (CAN 0x3FB), per av-firmware
# dbc/Dash.dbc. Published on each 0x3FB arrival with the latest throttle
# values.

# header.stamp is the receive time of the triggering 0x3FB frame.
std_msgs/Header header

float32 throttle_main_v
float32 throttle_tracking_v
float32 front_brake_pressure_v
