# C125 dash accelerometer rebroadcast, CAN 0x200 ("Accel_Trans"). Layout
# reverse-engineered from the dash config: two BIG-endian u16 values, each
# the corresponding DASH_IMU 0.01 g channel multiplied by 981:
#   bytes 0-1: channel 0x000F (lat, best guess), bytes 2-3: channel 0x0010
#   (long, best guess) — note the axis order is swapped vs DASH_IMU 0x556.
# Verified live: values / 981 exactly match the 0x556 0.01 g counts, so
# raw / 98100 = g.

# header.stamp is the CAN receive time.
std_msgs/Header header

uint16 accel_lat_raw
uint16 accel_long_raw
# Scaled to g (raw / 98100).
float32 accel_lat_g
float32 accel_long_g
