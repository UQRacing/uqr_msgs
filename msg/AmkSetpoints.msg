# Typed representation of a native AMK Setpoints frame (M150 -> inverter).
# Right is CAN 0x184; left is CAN 0x185; layout per av-firmware dbc/AMK.dbc.
# Complements AmkActualValues1/2 (inverter -> bus) so both directions of the
# drive interface are in the bags.

uint8 LEFT=0
uint8 RIGHT=1

# header.stamp is the CAN receive time.
std_msgs/Header header
uint8 side

# AMK control word bits.
bool inverter_on
bool dc_on
bool enable
bool error_reset

# Speed setpoint in native signed rpm. target_velocity_rpm = raw, scale 1.
# Older logger versions incorrectly multiplied the rpm field by six.
int16 target_velocity_raw
float32 target_velocity_rpm

# Torque limits, raw AMK units (0.1% of nominal torque per bit).
int16 torque_limit_positive_raw
int16 torque_limit_negative_raw
