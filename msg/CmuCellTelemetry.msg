# Per-CMU cell telemetry from the Prohelion CMU broadcast trio
# (CMU n occupies IDs 0x601+3(n-1) .. 0x603+3(n-1)):
#   first frame:  serial number, PCB temp, cell temp (0.1 degC steps)
#   second frame: cell voltages 0-3 (mV)
#   third frame:  cell voltages 4-7 (mV)
# Verified against live bus captures. Published per CMU on each third-frame
# arrival with the latest data from the first two.

# header.stamp is the receive time of the triggering third frame.
std_msgs/Header header

# 1-based CMU index derived from the CAN ID.
uint8 cmu_index
uint32 serial_number
float32 pcb_temp_c
float32 cell_temp_c
# Cell voltages in mV, index 0 = cell 0.
int16[8] cell_voltage_mv
