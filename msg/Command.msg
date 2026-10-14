# Complete path-follower or mission command consumed by VAM.
std_msgs/Header header
MotorCommand motors
SteeringCommand steering

# Select the fixed 1 m/s VAM ceiling for thesis MPCC commands only.
bool mpcc_active
