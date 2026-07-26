# Steering-wheel / dash switch states, CAN 0x3F0, per av-firmware
# dbc/Dash.dbc.

# header.stamp is the CAN receive time.
std_msgs/Header header

bool hv_switch
bool drive_switch
bool aux1_switch
bool aux2_switch
