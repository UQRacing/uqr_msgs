# Lossless typed representation of a native AMK Actual Values 1 CAN frame.
# Right is CAN 0x283; left is CAN 0x284. The AMK DBC does not define a
# physical unit/scale for currents, so their signed raw values are retained.
# The M150 firmware converts speed to rpm as raw * 6; both forms are included
# so PC logs match the vehicle channels without losing the source value.

uint8 LEFT=0
uint8 RIGHT=1

std_msgs/Header header
uint8 side
uint16 status_word
int16 speed_raw
float32 speed_rpm
int16 torque_current_raw
int16 magnetizing_current_raw
