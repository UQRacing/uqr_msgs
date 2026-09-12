# Status of one CAN message or one compound-message selector.
uint32 id
bool extended
# -1 for a non-compound frame.
int16 selector
bool received
builtin_interfaces/Time last_received
float64 age_sec
float64 timeout_sec
bool fresh
uint64 received_count
uint64 malformed_count
