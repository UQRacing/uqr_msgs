# C125 dash "Dash_Misc" frame, CAN 0x552. Layout reverse-engineered from
# the dash config: one little-endian u16 at bytes 0-1 carrying the dash's
# "BMS Pack Voltage" channel divided by 10000 — believed to land in whole
# volts (reads 0 with HV off; scale to be confirmed against a live HV-on
# pack voltage).

# header.stamp is the CAN receive time.
std_msgs/Header header

uint16 pack_voltage_raw
# Best-guess volts (raw * 1.0).
float32 pack_voltage_v
