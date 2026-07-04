# UQR Messages
This repo contains the ROS messages for the autonomous vehicle.
(Updated for ROS2 migration)

**Authors:**
- Matt Young (m.young2@uqconnect.edu.au)
- Madeleine Warner (m.warner@uqconnect.edu.au)
- Jared Lindsay

## Building
Should just be `colcon build`. After that, it will become available in all other UQRacing projects automatically.

## Current messages

| Message | Used by | Notes |
|---|---|---|
| `AVStatus` | vam2 (pub `/dfmm/status`), mission_launchers (sub) | **FROZEN** wire format — see below |
| `Safety` | mission_launchers `controllers/xbox.py` (`/vam/softEbs`) | EBS-request message |
| `VAMSoundRequest` | mission_launchers `controllers/xbox.py` (`/vam/soundRequest`) | Safety-sound request |

`Safety` and `VAMSoundRequest` are currently only referenced by `xbox.py`,
which is slated for a from-scratch rebuild (audit ML-P1-01 / gate Q4). They are
kept because the rebuild will re-use the softEbs / sound interfaces.

### Removed (legacy perception cluster)

Seven pre-ROS2 perception types were deleted in the 2026-07-04 audit pass
(UQM-P2) after a workspace-wide grep found **zero external consumers** — they
referenced only each other: `Cone3D`, `DepthImage`, `Map`, `NNConeDetection`,
`NNConeDetections`, `Perception`, `Rect2D`. The live perception stack publishes
`eufs_msgs/ConeArray` (see `stack/src/cone_detector_base.cpp`), not these. If a
future camera/NN pipeline needs them back, recover from git history rather than
re-authoring.

## AVStatus — AS status word

`AVStatus` is republished by **vam2** from the DFMM CAN state frame
(default id `0x119`, DLC 3). vam2 packs it in `on_dfmm_state()`
(`vam2/src/vam2.cpp`):

```
status.status     = (raw_b0 & 0xF8) | published_state   # low 3 bits = AS state
status.mission    = raw_b1                               # DFMM byte1
status.transition = raw_b2                               # DFMM byte2
```

where `raw_b0/b1/b2` are DFMM bytes 0/1/2. `published_state` is `raw_b0 & 0x07`
with vam2's READY-masking applied (DRIVING is reported as READY until steering
is initialised). Consumers (`mission_launchers/src/comp_things/mission_select.py`,
`tech_insp_mission.py`) recover each field by masking the low 3 bits (`& 0x07`).

`AVStatus.msg` now carries named `AS_STATE_*` and `*_MASK` constants documenting
this packing. **The wire format is FROZEN** (`/dfmm/status` consumers exist in
vam2 and mission_launchers): the three `uint8` fields and their layout must not
change. The constants are additive and ABI-safe.

### Mapping to eufs_msgs/CanState

`AVStatus` overlaps conceptually with the vendor `eufs_msgs/CanState` (which
has its own `AS_*` / `AMI_*` constants). We keep `AVStatus` because it is the
DFMM-native representation on this car; `CanState` is not a live interface here
(only 2 of 66 eufs_msgs types are used — audit EUM-P2-01).

The **AS-state** numbering happens to line up 1:1:

| AVStatus (`status & 0x07`) | eufs_msgs/CanState `as_state` |
|---|---|
| `AS_STATE_OFF` = 0 | `AS_OFF` = 0 |
| `AS_STATE_READY` = 1 | `AS_READY` = 1 |
| `AS_STATE_DRIVING` = 2 | `AS_DRIVING` = 2 |
| `AS_STATE_EMERGENCY` = 3 | `AS_EMERGENCY_BRAKE` = 3 |
| `AS_STATE_FINISHED` = 4 | `AS_FINISHED` = 4 |

### ⚠️ Mission numbering does NOT line up — never bridge numerically

The **mission** numbering is scheme-specific and inconsistent across the three
places missions are numbered. `AVStatus.mission` carries the DFMM byte verbatim;
`mission_select.py` maps `mission & 0x07` to launch files (`1=trackdrive`,
`2=brake_test`, `3=inspection`). Neither the DFMM scheme nor the two eufs
schemes agree, and — critically (audit **EUM-P1-01**) — the two vendor schemes
disagree with each other and **not by a constant offset**:

| Mission | `eufs_msgs/SetMission.srv` | `eufs_msgs/CanState` `ami_state` | offset |
|---|---|---|---|
| ACCELERATION | 1 | `AMI_ACCELERATION` = 11 | +10 |
| SKIDPAD | 2 | `AMI_SKIDPAD` = 12 | +10 |
| AUTOCROSS | 3 | `AMI_AUTOCROSS` = 13 | +10 |
| TRACK_DRIVE | 4 | `AMI_TRACK_DRIVE` = 14 | +10 |
| ADS_INSPECTION | 7 | `AMI_ADS_INSPECTION` = 16 | +9 |
| ADS_EBS_TEST | 6 | `AMI_ADS_EBS` = 17 | +11 |
| MANUAL_DRIVING | 5 | `AMI_MANUAL` = 21 | +16 |

**Never convert a mission number between `AVStatus`, `SetMission` and
`CanState` by arithmetic.** If a bridge is ever needed, use an explicit,
reviewed lookup table — a numeric offset will silently select the wrong mission.

## Cone-colour enums

The deleted `Cone3D`/`NNConeDetection` messages each embedded a duplicated
integer colour enum (`CONE_BLUE=0`, `CONE_YELLOW=1`, `CONE_ORANGE=2`,
`CONE_UNKNOWN=3`). With those messages removed, uqr_msgs no longer defines a
cone-colour enum at all, and the duplication is gone.

The **live** cone representation is `eufs_msgs/ConeArray` (and
`ConeArrayWithCovariance`), which encode colour **structurally** — one array per
colour (`blue_cones`, `yellow_cones`, `orange_cones`, `big_orange_cones`,
`unknown_color_cones`) rather than an integer field. New code should use that
structural scheme; do not reintroduce a parallel integer colour enum in
uqr_msgs.

## Licence
Mozilla Public Licence v2.0 (SPDX `MPL-2.0`) — full text in `LICENSE.txt`.
