# Lossless typed representation of a native AMK Actual Values 2 CAN frame.
# Right is CAN 0x285; left is CAN 0x286. Temperature raw values use the
# vehicle firmware's 0.1 degree C scale; both raw and converted values are
# published so bags can be reprocessed without losing source data.

uint8 LEFT=0
uint8 RIGHT=1

std_msgs/Header header
uint8 side
int16 motor_temperature_raw
float32 motor_temperature_c
int16 inverter_temperature_raw
float32 inverter_temperature_c
uint16 diagnostic_number
int16 igbt_temperature_raw
float32 igbt_temperature_c
