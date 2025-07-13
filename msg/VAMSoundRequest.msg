# This file is a message for requesting the VAM to emit a particular safety sound
std_msgs/Header header

# VAM activate sound
int32 VAM_SOUND_ACTIVATE=0
# Note: Playing the SoftEBS sound is not permitted. Instead, publish to the VAM SoftEBS request topic. 
# See VAM docs for more details.

# Which safety sound (see above) to play
int32 sound_type
