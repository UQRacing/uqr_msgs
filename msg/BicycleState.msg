# M150 bicycle-model frame, CAN 0x171: two big-endian floats
# (CAN.Tx Bicycle.m1scr) — the same frame bicycle_model consumes for
# odometry, recorded here in its native units.

# header.stamp is the CAN receive time.
std_msgs/Header header

# Vehicle.Wheel Speed.Reference as transmitted (m/s).
float32 wheel_speed_reference
# Driver.Steering Angle.Wheel Angle as transmitted.
float32 steering_wheel_angle
