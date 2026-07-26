# MoTeC PDM15 device snapshot, published on /pdm15.
# Aggregates the M150 -> PDM15 command frame (0x128), the PDM's 0x520
# heartbeat echo, and its standard CAN telemetry (base 0x700, per the PDM
# User Manual appendix). Output channel names come from the config in the
# av-firmware repo at runtime. Published on each telemetry summary frame
# (20 Hz) and immediately whenever a command field changes.

# header.stamp is the receive time of the triggering frame.
std_msgs/Header header

# --- command state (0x128, M150 -> PDM15, sampled from 500 Hz) ---
bool cmd_brake_light
bool cmd_buzzer
bool cmd_sdc
bool cmd_r2d_buzzer
bool cmd_ebs_buzzer
bool cmd_asms
# 4-bit AV heartbeat value the M150 asks the PDM to echo.
uint8 cmd_heartbeat_echo
bool cmd_heartbeat_stop_alert

# Last heartbeat echo the PDM15 transmitted back on 0x520.
uint8 heartbeat_echo

# --- standard telemetry (base 0x700) ---
uint8 internal_temp_c
# 0.1216 V steps on the wire.
float32 battery_v
# One or more outputs is in Fault or Over-Current error.
bool global_error
uint8 total_current_a
# 9.5 V internal rail (0.0615 V steps).
float32 rail_9v5_v
uint8 reset_source

# Per-output telemetry, index 0 = output channel 1.
Pdm15Output[15] outputs

# Switch inputs, index 0 = input 1 (0.2 V steps for voltages).
bool[23] input_state
float32[23] input_voltage_v
