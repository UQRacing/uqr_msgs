# UQR Messages
This repo contains the ROS messages for the autonomous vehicle.
(Updated for ROS2 migration)

**Authors:**
- Matt Young (m.young2@uqconnect.edu.au)
- Madeleine Warner (m.warner@uqconnect.edu.au)
- Jared Lindsay

## Building
Should just be `colcon build`. After that, it will become available in all other UQRacing projects automatically.

## M1 enum generation

The build generates `AVDebug.msg`, `FirmwareEnums.msg`, the C++ header
`uqr_msgs/firmware_enums.hpp`, and `share/uqr_msgs/firmware/firmware_enums.json`
from the bundled `firmware/Project.m1prj`. `firmware/source.json` records its
av-firmware commit and SHA-256. A mismatched snapshot fails the build. No network
access or firmware checkout is needed to build a pinned workspace.

M1 values are `ContainerOrder - ContainerOrder(Default)`, even when XML members
are out of order. `FirmwareEnums` exposes these signed values for every enum,
including Derating Driver Lights and Torque Map Level. `AVDebug` retains unsigned
raw CAN fields and exposes constants encoded to each field's width. For example,
Drive State Emergency is -3 in M1 and 13 in the four-bit CAN field. PC Watchdog
Emergency is -1 in M1 and 3 in the two-bit CAN field. Negative wire encoding is
the expected unsigned truncation and still needs a hardware capture to confirm.

To update the schema, copy `UQR-AV/01.00/Project.m1prj` from the intended
av-firmware commit, update both the full revision and the file's SHA-256 in
`firmware/source.json`, and rebuild `uqr_msgs` and its dependants. Do not edit
generated enum values. The schema revision does not identify what was flashed.

For historical bags, use the `flashed_revision` field on `/system/firmware` to
retrieve that revision's project. Export its signed enum table with:

```bash
ros2 run uqr_msgs generate_firmware_enums.py --project /path/to/Project.m1prj --dump-json
```

This works with earlier mission tables, including Track Drive=1, without changing
the installed deployment schema. Do not apply today's mission table to older
bags. If provenance is absent or unknown, require a confirmed revision instead
of silently inferring one from a bag date.

## Licence
Mozilla Public Licence v2.0
