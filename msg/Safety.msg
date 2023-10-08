# This message can be published to the VAM to request EBS activation

std_msgs/Header header
bool ebs_activate # Write true to activate the BS instantly. Once true, cannot be set to false.
string ebs_reason # Reason for EBS activation if bs_activate is True, otherwise empty string
