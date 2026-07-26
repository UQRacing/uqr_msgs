# C125 dash internal accelerometer, CAN 0x556 ("DASH_IMU"). Layout reverse-
# engineered from the dash config (AV.c125v65 CAN transmit records): three
# little-endian u16 G-force channels in 0.01 g steps —
#   bytes 0-1: MoTeC builtin channel 0x0010, bytes 2-3: channel 0x000F,
#   bytes 4-5: channel 0x001C (vertical; reads 1.00 g at rest, verified).
# The lat/long assignment of the two horizontal axes is a best guess
# (0x000F = lat, 0x0010 = long) — confirm with a braking event, where
# longitudinal should spike.

# header.stamp is the CAN receive time.
std_msgs/Header header

uint16 g_long_raw
uint16 g_lat_raw
uint16 g_vert_raw
# Scaled to g (raw * 0.01).
float32 g_long
float32 g_lat
float32 g_vert
