# This file contains a single detection of a 2D cone position in a camera frame by a neural network

# Cone colours
int32 CONE_BLUE=0
int32 CONE_YELLOW=1
int32 CONE_ORANGE=2
int32 CONE_UNKNOWN=3

# Bounding box
Rect2D bbox
# Detected cone colour (see cone colours constants above)
int32 colour