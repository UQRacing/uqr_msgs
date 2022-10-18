# Requests that the VAM emit a particular safety sound

# VAM activate sound
int32 VAM_SOUND_ACTIVATE=0
# Playing the SoftEBS sound is not permitted. Instead, publish to the VAM SoftEBS request topic. See docs for more details.

# Which safety sound (see above) to play
int32 soundType
