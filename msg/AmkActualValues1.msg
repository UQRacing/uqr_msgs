# Lossless typed representation of a native AMK Actual Values 1 CAN frame.
# Right is CAN 0x283; left is CAN 0x284. The AMK DBC does not define a
# physical unit/scale for currents, so their signed raw values are retained.
# The M150 firmware converts speed to rpm as raw * 6; both forms are included
# so PC logs match the vehicle channels without losing the source value.

uint8 LEFT=0
uint8 RIGHT=1

# Derived from the AMK status word using the same priority as the M150.
uint8 INVERTER_STATE_CAN_TIMEOUT=0
uint8 INVERTER_STATE_SYSTEM_READY=1
uint8 INVERTER_STATE_FAULT=2
uint8 INVERTER_STATE_EVENT=3
uint8 INVERTER_STATE_DERATING=4

uint8 BOOT_STATE_FAULT=0
uint8 BOOT_STATE_SYSTEM_READY=1
uint8 BOOT_STATE_HV_ACTIVATION_REQUESTED=2
uint8 BOOT_STATE_HV_ACTIVATED=3
uint8 BOOT_STATE_CONTROLLER_ENABLE_REQUESTED=4
uint8 BOOT_STATE_CONTROLLER_ENABLED=5

std_msgs/Header header
uint8 side
uint16 status_word
bool system_ready
bool error
bool warning
bool quit_dc_on
bool dc_on
bool quit_inverter_on
bool inverter_on
bool derating
uint8 inverter_state
string inverter_state_name
uint8 boot_state
string boot_state_name
int16 speed_raw
float32 speed_rpm
int16 torque_current_raw
int16 magnetizing_current_raw
