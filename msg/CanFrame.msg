# Unmodified classic CAN frame. Receive timestamp from SocketCAN, not publish time.
std_msgs/Header header
string bus
uint32 id
bool extended
bool rtr
bool error
uint8 dlc
uint8[8] data
