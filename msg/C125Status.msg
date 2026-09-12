# C125 dash device snapshot, published on /c125 at 50 Hz, including bus silence. Aggregates every dash-originated frame: DBC-defined
# transmits (Dash.dbc) plus the dash-config-only frames reverse-engineered
# from AV.c125v65 (DASH_IMU 0x556, Accel_Trans 0x200, Dash_Misc 0x552 —
# see av-firmware AGENTS.md).

# header.stamp is the publish time; all fields are latest-received values.
std_msgs/Header header

# --- steering-wheel / dash switches (0x3F0) ---
bool hv_switch
bool drive_switch
bool aux1_switch
# Deprecated, always false: bit 3 is now nav_up.
bool aux2_switch
bool nav_up
bool nav_left
bool nav_down
bool nav_right
bool nav_confirm

# --- front wheel speeds (0x3F1 LE / 0x3F2 BE, raw * 6 = rpm) ---
float32 front_left_wheel_rpm
float32 front_right_wheel_rpm

# --- analog inputs (0x3F8/0x3F9 throttle, 0x3FB brake pressure) ---
float32 throttle_main_v
float32 throttle_tracking_v
float32 front_brake_pressure_v

# --- internal accelerometer (0x556 "DASH_IMU", signed 0.01 g steps) ---
# Lat/long assignment is a best guess pending a braking event; vertical
# reads 1.00 g at rest.
float32 g_lat
float32 g_long
float32 g_vert
# The same channels rebroadcast signed big-endian on 0x200 ("Accel_Trans").
# This older frame overflows beyond +/-0.334 g; prefer g_lat/g_long.
float32 accel_lat_g
float32 accel_long_g

# --- 0x552 "Dash_Misc": dash's view of the HV pack voltage ---
# Deprecated: NaN until the Dash_Misc channel calibration is established.
# Use /accum.pack_voltage_v for measured pack voltage.
float32 pack_voltage_v
uint16 pack_voltage_raw

# --- display values the M150 sends to the dash (0x3FD/0x3FE) ---
# Current M150 does not populate these bytes. Use /amk/*/actual_values2.
bool inverter_temperatures_valid
uint8 left_inverter_temp_c
uint8 right_inverter_temp_c
bool asms
uint8 watchdog_status
bool as_fault
# kPa, as transmitted by M150 CAN.Tx Dash Vals 2.
float32 canister_pressure
uint8 max_cell_temp_c
float32 max_cell_voltage_v
uint8 min_cell_temp_c
float32 min_cell_voltage_v
uint8 left_motor_temp_c
uint8 right_motor_temp_c

# 0x3F4 cursor feedback from the dash.
uint8 cursor_line
uint8 display_mode

# --- SBG / connectivity status shown on the dash (0x3FF) ---
float32 sbg_pos_acc_z_m
float32 sbg_yaw_acc_rad
uint8 sbg_solution_mode
bool tailscale_up
bool sbg_locked

# Consult source freshness before interpreting held snapshot values.
CanSourceStatus[] sources
