# Typed ROS representation of DFMM CAN frame 0x11A (AV Debug).
# The header timestamp is the VAM receive time.

std_msgs/Header header

uint8 vehicle_state
uint8 drive_state
bool vam_timeout
uint8 heartbeat_failure
uint8 dfmm_failure_mode
uint8 drive_state_failure
uint8 ebs_control
uint8 inverter_left_boot_state
uint8 inverter_right_boot_state
uint8 pc_watchdog_status
uint8 precharge_state
bool av_emergency
uint8 checkup_status
bool sdc_sense
bool pc_watchdog_timeout
bool throttle_main_link_ok
bool throttle_tracking_link_ok
bool steering_timeout
