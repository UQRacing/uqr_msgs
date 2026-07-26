# FSG wireless RES (remote emergency stop) Data frame, CAN 0x191,
# layout per av-firmware dbc/RES.dbc.

# header.stamp is the CAN receive time.
std_msgs/Header header

# Switch states as transmitted by the RES base station.
bool hv_switch
bool drive_switch
bool alive_bit_a
bool alive_bit_b
# Signed radio link quality as transmitted.
int8 radio_quality
