# MoTeC PDM15 standard CAN telemetry snapshot, aggregated from the compound
# messages at base 0x700 (PDM User Manual, "CAN Output Messages", 20 Hz):
#   +0 input states / internal temp / battery / global error / total current,
#   +1 output currents, +2 output loads, +3 output voltages,
#   +4 output status, +5 input voltages.
# Published on each summary (base+0, compound 3) arrival with the latest
# data from the other compounds.

uint8 OUTPUT_STATUS_OFF=0
uint8 OUTPUT_STATUS_ON=1
uint8 OUTPUT_STATUS_OVER_CURRENT=2
uint8 OUTPUT_STATUS_FAULT=4

# header.stamp is the receive time of the triggering summary frame.
std_msgs/Header header

# Switch input states, index 0 = input 1.
bool[23] input_state
# Input pin voltages (0.2 V steps), index 0 = input 1.
float32[23] input_voltage_v

# PDM internal temperature (1 degC steps).
uint8 internal_temp_c
# Battery voltage (0.1216 V steps).
float32 battery_v
# One or more outputs is in Fault or Over-Current error.
bool global_error
# Total current (1 A steps).
uint8 total_current_a
# 9.5 V internal rail voltage (0.0615 V steps).
float32 rail_9v5_v
uint8 reset_source

# Per-output telemetry, index 0 = output channel 1 (PDM15: 15 channels).
# Currents: outputs 1-8 in 0.5 A steps, outputs 9+ in 0.2 A steps.
float32[15] output_current_a
# Load in percent of the configured fuse current.
uint8[15] output_load_pct
# Output pin voltages (0.2 V steps).
float32[15] output_voltage_v
# OUTPUT_STATUS_* values.
uint8[15] output_status
