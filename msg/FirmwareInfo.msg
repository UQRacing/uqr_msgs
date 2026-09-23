# Published by VAM on /system/firmware, reliable and transient-local.
std_msgs/Header header
# Full av-firmware commit recorded by the operator after flashing, or "unknown".
# This is operator-supplied provenance, not an ECU readback.
string flashed_revision
string revision_source
# Source used to generate the installed ROS constants and decoder name tables.
string decoder_revision
string project_sha256
