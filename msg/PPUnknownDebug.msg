# This message was used for debugging Matt's unknown path planner, it may be unused as of now?

std_msgs/Header header

# Blue cones we observed (after filtering, etc)
geometry_msgs/Polygon observedBlueCones
# Yellow cones we observed (after filtering, etc)
geometry_msgs/Polygon observedYellowCones
# Cone pairs between yellow and blue cones
uqr_msgs/ConePair[] conePairs

# Current generated trajectory
geometry_msgs/Polygon currentTrajectory
# Potential paths generated by the RRT
geometry_msgs/Polygon[] rrtPaths
