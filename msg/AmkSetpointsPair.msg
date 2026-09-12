# Both AMK inverter setpoint frames (M150 -> inverters), published on /amk
# on each right-side frame with the latest left-side values. Each side keeps
# its own receive timestamp in its header.

# header.stamp is the receive time of the triggering right-side frame.
std_msgs/Header header

AmkSetpoints left
AmkSetpoints right

# Consult source freshness before interpreting held snapshot values.
CanSourceStatus[] sources
