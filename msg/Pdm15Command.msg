# Typed representation of the MoTeC PDM15 Command frame, CAN 0x128.
# Sent by the M150 at 500 Hz to drive PDM15 outputs; the can_logger node
# publishes it on change plus a 1 Hz keepalive. Layout per av-firmware
# dbc/PDM15.dbc (big-endian frame).

# header.stamp is the CAN receive time.
std_msgs/Header header

bool brake_light
bool buzzer
bool sdc
bool r2d_buzzer
bool ebs_buzzer
bool asms
# 4-bit AV heartbeat value echoed back by the P14 on 0x520.
uint8 heartbeat_echo
bool heartbeat_stop_alert
