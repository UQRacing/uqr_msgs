# Typed representation of PDM P14 (blackbox) State command, CAN 0x117.
# Sent by the M150 at 500 Hz to drive the P14's outputs; the can_logger node
# publishes it on change plus a 1 Hz keepalive. Layout per av-firmware
# dbc/PDM P14.dbc (big-endian frame).

# header.stamp is the CAN receive time.
std_msgs/Header header

bool fan
bool pumps
# Driveline.EBS.Control enum as transmitted (0-6).
uint8 ebs_control
bool sdc
# Control.AV.ASSI.Status as transmitted (signed).
int8 assi_status
bool dcdc_48v_precharge_power
bool dcdc_48v_power
