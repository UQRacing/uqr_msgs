# One PDM P14 (blackbox) output channel, with its configured name resolved
# at runtime from av-firmware config/blackbox-p14/AV.bp3 (e.g. "48V DCDC A",
# "CAN PWR", "PC PWR").

string name
# 0.2 A steps on the wire.
float32 current_a
# Percent of the configured fuse current.
uint8 load_pct
bool on
bool fault
