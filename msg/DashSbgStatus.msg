# SBG / connectivity status shown on the dash, CAN 0x3FF, per av-firmware
# dbc/Dash.dbc.

# header.stamp is the CAN receive time.
std_msgs/Header header

float32 sbg_pos_acc_z_m
float32 sbg_yaw_acc_rad
uint8 sbg_solution_mode
bool tailscale_up
bool sbg_locked
