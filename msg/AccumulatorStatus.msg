# Accumulator (HV battery) snapshot, published on /accum.
# Aggregates the Prohelion BMU broadcast set (base 0x600, 0x6F4-0x6FD),
# the per-CMU cell broadcasts (0x601-0x612) and the M150 -> BMU Ignition
# frame (0x505). Published on each PackVoltageCurrent (0x6FA) arrival
# (10 Hz). SOC values are IEEE-754 floats on the wire; pack voltage/current
# are integer mV/mA — both verified against live captures.

# header.stamp is the receive time of the triggering 0x6FA frame.
std_msgs/Header header

# Identity (0x600, 0x6FD).
uint32 device_id
int32 serial_number
uint8 bmu_hardware_version
uint8 bmu_model_id

# State of charge. Percent fields are 0-100; the Ah fields are amp-hours
# consumed since full, per the Prohelion spec.
float32 soc_ah
float32 soc_percent
float32 balance_soc_ah
float32 balance_soc_percent

# Pack electrical state (0x6FA), converted from mV / mA.
float32 pack_voltage_v
float32 pack_current_a

# Cell extremes (0x6F8, 0x6F9); CMU/cell indices locate the extreme cell.
uint16 min_cell_voltage_mv
uint16 max_cell_voltage_mv
uint8 min_cell_voltage_cmu
uint8 min_cell_voltage_cell
uint8 max_cell_voltage_cmu
uint8 max_cell_voltage_cell
float32 min_cell_temp_c
float32 max_cell_temp_c
uint8 min_cell_temp_cmu
uint8 min_cell_temp_cell
uint8 max_cell_temp_cmu
uint8 max_cell_temp_cell

# Precharge (0x6F7); state is the raw Prohelion enum.
uint8 precharge_contactor_driver_status
uint8 precharge_state
uint16 contactor_12v_supply_mv

# Fan / housekeeping (0x6FC).
uint16 fan_speed_0_rpm
uint16 fan_speed_1_rpm
uint16 fan_and_contactors_current_ma
uint16 cmu_current_ma

# Charger control information (0x6F6).
int16 charging_cell_voltage_error_mv
int16 discharging_cell_voltage_error_mv
float32 cell_temp_margin_c
int16 total_pack_capacity_ah

# Balance thresholds + pack status flag (0x6FB).
uint16 balance_threshold_rising_mv
uint16 balance_threshold_falling_mv
uint8 pack_status_flags

# Extended pack status bits (0x6FD).
bool status_cell_over_volt
bool status_cell_under_volt
bool status_cell_over_temp
bool status_measurement_untrusted
bool status_cmu_comms_timeout
bool status_vehicle_comms_timeout
bool status_bmu_setup_mode
bool status_cmu_can_bus_power
bool status_pack_isolation_test_fail
bool status_soc_measurement_invalid
bool status_12v_supply_low
bool status_contactor_stuck
bool status_cmu_extra_cell

# Ignition frame 0x505 (M150 -> BMU), raw value.
uint8 ignition

# Per-CMU cell telemetry, index 0 = CMU 1.
CmuCells[6] cmus
