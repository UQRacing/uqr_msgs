# One immutable path/profile result from a specific map and planning request.
# path.header.frame_id is the actual coordinate frame; metadata is never a frame.
# speed_mps has exactly one finite nonnegative entry per path pose.
nav_msgs/Path path
uint64 map_generation
uint64 request_id
# "optimizer" or "centerline".
string source
float64[] speed_mps
