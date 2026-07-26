# Values the M150 sends to the dash display, aggregated from CAN 0x3FD
# (Vals1) and 0x3FE (Vals2), per av-firmware dbc/Dash.dbc. Useful in bags as
# an independent record of what the driver display showed.
# Published on each Vals2 arrival with the latest Vals1 values.

# header.stamp is the receive time of the triggering Vals2 frame.
std_msgs/Header header

# Vals1.
uint8 left_inverter_temp_c
uint8 right_inverter_temp_c
bool asms
uint8 watchdog_status
bool as_fault

# Vals2.
float32 canister_pressure
uint8 max_cell_temp_c
float32 max_cell_voltage_v
uint8 min_cell_temp_c
float32 min_cell_voltage_v
uint8 left_motor_temp_c
uint8 right_motor_temp_c
