# One MoTeC PDM15 output channel, with its configured name resolved at
# runtime from av-firmware config/motec-pdm15/AV.pdm (e.g. "Inverter/HVJ
# power", "PC Fan", "Brake Light").

uint8 STATUS_OFF=0
uint8 STATUS_ON=1
uint8 STATUS_OVER_CURRENT=2
uint8 STATUS_FAULT=4

string name
# Outputs 1-8 are 0.5 A steps on the wire; outputs 9+ are 0.2 A steps.
float32 current_a
# Percent of the configured fuse current.
uint8 load_pct
# 0.2 V steps on the wire.
float32 voltage_v
# STATUS_* values.
uint8 status
