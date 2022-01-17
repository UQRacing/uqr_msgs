std_msgs/Header header
bool ebs_activate # Write true to activate EBS instantly. Once true, cannot be set to false.
string ebs_reason # Reason for EBS activation if ebs_activate is True, otherwise empty string