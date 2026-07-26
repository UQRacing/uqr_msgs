# Front wheel speeds measured by the dash, aggregated from CAN 0x3F1 (FLWS)
# and 0x3F2 (FRWS), per av-firmware dbc/Dash.dbc (raw * 6 = rpm).
# Published on each FRWS arrival with the latest FLWS value.

# header.stamp is the receive time of the triggering FRWS frame.
std_msgs/Header header

uint16 front_left_raw
uint16 front_right_raw
float32 front_left_rpm
float32 front_right_rpm
