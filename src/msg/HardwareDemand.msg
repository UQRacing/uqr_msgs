# Hardware Demand message - conversion between high level commands and actuators

std_msgs/Header header
std_msgs/Float64 steering
std_msgs/Float64 throttle
std_msgs/Float64 brake

####### Demand #######
# steering: Demand angle in radians | 0 = straight ahead | +ve = left | -ve = right
# throttle: Vehicle m/s demand [0,-]
# brake: Demand in percentage [0,1] | 0 = no brake | 1 = full brake

####### Feedback #######
# steering: Current angle in radians | 0 = straight ahead | +ve = left | -ve = right
# throttle: Current rpm [0,-]
# brake: Current position in percentage [0,1] | 0 = no brake | 1 = full brake
