# PDM P14 (blackbox PDM) device snapshot, published on /p14.
# Aggregates the M150 -> P14 command frame (0x117) and the P14's standard
# telemetry set (base 0x5F0, per the Moristech "P14 CAN bus Transmit
# Information" doc v1.0). Output channel names come from the config in the
# av-firmware repo at runtime. Published on each telemetry summary frame
# (20 Hz) and immediately whenever a command field changes.

# header.stamp is the receive time of the triggering frame.
std_msgs/Header header

# --- command state (0x117, M150 -> P14, sampled from 500 Hz) ---
bool cmd_fan
bool cmd_pumps
# Driveline.EBS.Control enum as transmitted (0-6).
uint8 cmd_ebs_control
bool cmd_sdc
int8 cmd_assi_status
bool cmd_dcdc_48v_precharge_power
bool cmd_dcdc_48v_power

# --- telemetry (0x5F0-0x5F4) ---
# 24 user-programmable switch/function state bits.
uint32 state_bits
uint8 internal_temp_c
uint8 aux_temp_c
# 0.125 V steps on the wire; this is the 24V LV battery.
float32 battery_v
uint8 total_current_a
bool pdm_high_temp
bool battery_low
bool output_faulted
uint8 counter_1
uint8 counter_2

# Per-output telemetry, index 0 = output channel 1.
P14Output[14] outputs
