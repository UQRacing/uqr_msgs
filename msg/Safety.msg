# This message can be published to the VAM to force a SoftEBS activation

std_msgs/Header header
bool softebs_activate # Write true to activate the SoftEBS instantly. Once true, cannot be set to false.
string softebs_reason # Reason for SoftEBS activation if softebs_activate is True, otherwise empty string
