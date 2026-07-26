# One Prohelion CMU's cell telemetry (part of AccumulatorStatus).
# CMU n broadcasts on 0x601+3(n-1): serial + temps (0.1 degC), then cell
# voltages 0-3 and 4-7 in mV. -32768 marks an unfitted cell slot.

uint8 cmu_index
uint32 serial_number
float32 pcb_temp_c
float32 cell_temp_c
int16[8] cell_voltage_mv
