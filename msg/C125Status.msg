# C125 dash device snapshot, published on /c125 at 50 Hz while the dash is
# alive on the bus. Aggregates every dash-originated frame: DBC-defined
# transmits (Dash.dbc) plus the dash-config-only frames reverse-engineered
# from AV.c125v65 (DASH_IMU 0x556, Accel_Trans 0x200, Dash_Misc 0x552 —
# see av-firmware AGENTS.md).

# header.stamp is the publish time; all fields are latest-received values.
std_msgs/Header header

# --- steering-wheel / dash switches (0x3F0) ---
bool hv_switch
bool drive_switch
bool aux1_switch
bool aux2_switch

# --- front wheel speeds (0x3F1/0x3F2, raw * 6 = rpm) ---
float32 front_left_wheel_rpm
float32 front_right_wheel_rpm

# --- analog inputs (0x3F8/0x3F9 throttle, 0x3FB brake pressure) ---
float32 throttle_main_v
float32 throttle_tracking_v
float32 front_brake_pressure_v

# --- internal accelerometer (0x556 "DASH_IMU", 0.01 g steps) ---
# Lat/long assignment is a best guess pending a braking event; vertical
# reads 1.00 g at rest.
float32 g_lat
float32 g_long
float32 g_vert
# The same channels rebroadcast big-endian on 0x200 ("Accel_Trans").
float32 accel_lat_g
float32 accel_long_g

# --- 0x552 "Dash_Misc": dash's view of the HV pack voltage ---
float32 pack_voltage_v

# --- display values the M150 sends to the dash (0x3FD/0x3FE) ---
uint8 left_inverter_temp_c
uint8 right_inverter_temp_c
bool asms
uint8 watchdog_status
bool as_fault
float32 canister_pressure
uint8 max_cell_temp_c
float32 max_cell_voltage_v
uint8 min_cell_temp_c
float32 min_cell_voltage_v
uint8 left_motor_temp_c
uint8 right_motor_temp_c

# --- SBG / connectivity status shown on the dash (0x3FF) ---
float32 sbg_pos_acc_z_m
float32 sbg_yaw_acc_rad
uint8 sbg_solution_mode
bool tailscale_up
bool sbg_locked
