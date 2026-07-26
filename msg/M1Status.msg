# M150 telemetry export, published on /m1: the bicycle-model frame 0x171
# (two big-endian floats per CAN.Tx Bicycle.m1scr) — the same frame
# bicycle_model consumes for odometry, in its native units.

# header.stamp is the CAN receive time.
std_msgs/Header header

# Vehicle.Wheel Speed.Reference as transmitted (m/s).
float32 wheel_speed_reference
# Driver.Steering Angle.Wheel Angle as transmitted.
float32 steering_wheel_angle
