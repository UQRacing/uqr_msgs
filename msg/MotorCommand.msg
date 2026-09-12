# Per-rear-motor limits. VAM validates and quantizes these values for the
# av-firmware PC motor command on standard CAN ID 0x172.

# Forward-only motor-speed ceilings. The wire format rounds these down to
# 100 rpm steps and rejects values above 25,500 rpm.
uint16 rear_right_speed_limit_rpm
uint16 rear_left_speed_limit_rpm

# Positive and negative torque magnitudes in motor N.m. Negative limits are
# positive magnitudes; VAM and the M150 must not negate these values here.
float32 rear_right_positive_torque_limit_nm
float32 rear_right_negative_torque_limit_nm
float32 rear_left_positive_torque_limit_nm
float32 rear_left_negative_torque_limit_nm
