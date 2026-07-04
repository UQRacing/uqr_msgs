# Autonomous System status word, republished from the DFMM CAN state frame.
#
# Producer:  vam2 (/dfmm/status) — src/vam2.cpp on_dfmm_state():
#              status.status     = (raw_b0 & 0xF8) | published_state
#              status.mission    = raw_b1
#              status.transition = raw_b2
#            where raw_b0/b1/b2 are bytes 0/1/2 of the DFMM RX frame
#            (default CAN id 0x119, DLC 3) — see vam2/include/dfmm_protocol.hpp.
# Consumers: mission_launchers mission_select.py / tech_insp_mission.py, which
#            recover each field by masking the low 3 bits (& 0x07).
#
# WIRE FORMAT IS FROZEN: the three uint8 fields and their byte layout must not
# change. The constants below are additive documentation of the existing
# packing — they add no fields and are ABI-safe.

std_msgs/Header header

# --- status --------------------------------------------------------------
# Low 3 bits (& 0x07) = Autonomous System state. The upper 5 bits carry the
# untouched high bits of DFMM byte0 (vam2: `raw_b0 & 0xF8`) and must be masked
# off before comparing to the AS_STATE_* constants below.
# These values mirror vam2::AS_STATUS_* (vam2/include/vam2.hpp:37-41) and
# vam2::dfmm::kAs* (vam2/include/dfmm_protocol.hpp:15-19).
uint8 AS_STATE_MASK=7          # 0x07 — apply to `status` to recover the state
uint8 AS_STATE_OFF=0
uint8 AS_STATE_READY=1
uint8 AS_STATE_DRIVING=2
uint8 AS_STATE_EMERGENCY=3
uint8 AS_STATE_FINISHED=4
uint8 status

# --- mission -------------------------------------------------------------
# DFMM byte1 verbatim. mission_select.py decodes the mission number with
# `mission & 0x07`. NOTE: this numbering is DFMM/vam2-specific and does NOT
# match eufs_msgs/CanState AMI_* or eufs_msgs/SetMission — see the README
# "AS status mapping" section. Never bridge these numerically.
uint8 MISSION_MASK=7           # 0x07 — apply to `mission` to recover the number
uint8 mission

# --- transition ----------------------------------------------------------
# DFMM byte2 verbatim. Consumers decode the transition code with
# `transition & 0x07`.
uint8 TRANSITION_MASK=7        # 0x07 — apply to `transition` to recover the code
uint8 transition
