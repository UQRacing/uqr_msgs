# 3D cone position, estimated by the perception stack

# Cone colours (inherited from NNConeDetection.msg)
int32 CONE_BLUE=0
int32 CONE_YELLOW=1
int32 CONE_ORANGE=2
int32 CONE_UNKNOWN=3

# Estimated 3D position of the cone
geometry_msgs/Point pos
# Detected colour of this cone
int32 colour
