# PDM P14 (blackbox PDM) telemetry snapshot, aggregated from its five
# standard transmit frames at base 0x5F0 ("P14 CAN bus Transmit Information"
# doc v1.0, Moristech Black Box PCM):
#   0x5F0 states/temps/battery/total current, 0x5F1 output currents,
#   0x5F2 output loads, 0x5F3 output on/fault bits, 0x5F4 counters,
#   plus the 0x520 heartbeat-echo Response frame.
# Published on each 0x5F0 arrival with the latest data from the other frames.
#
# Output channel mapping (config/blackbox-p14/AV.bp3): 2=48V DCDC A,
# 4=CAN PWR, 5=48V DCDC B, 6=LiDAR, 7=EBS Solenoid 2, 8=DCDC Precharge,
# 9=SDC, 10=EBS Fill, 11=PC PWR, 12=EBS Solenoid 1 (1,3,13,14 unused).

# header.stamp is the receive time of the triggering 0x5F0 frame.
std_msgs/Header header

# 24 user-programmable switch/function state bits (0x5F0 bytes 0-2).
uint32 state_bits

# Temperatures in degrees Celsius (1 degC steps, 0-125).
uint8 internal_temp_c
uint8 aux_temp_c

# Battery volts (0.125 V steps) and total PDM current (1 A steps).
float32 battery_v
uint8 total_current_a

# Global status bits.
bool pdm_high_temp
bool battery_low
bool output_faulted

# Per-output telemetry, index 0 = output channel 1 (14 channels).
# Currents in 0.2 A steps; loads in percent of the configured fuse current.
float32[14] output_current_a
uint8[14] output_load_pct
bool[14] output_on
bool[14] output_fault

# First two counter-list counter values (0x5F4).
uint8 counter_1
uint8 counter_2

# Last heartbeat echo seen on the 0x520 Response frame.
uint8 heartbeat_echo
