#!/usr/bin/env python3
"""Generate ROS constants and decoder tables from an exact M1 project snapshot.

Also usable offline: --project <revision's Project.m1prj> --dump-json.
Never infer a flashed revision from the age or HEAD of a checkout.
"""
import argparse
import hashlib
import json
from pathlib import Path
import re
import xml.etree.ElementTree as ET


# Protocol field widths, not enum ordinals. Names/values come only from XML.
DEBUG_FIELDS = (
    ('Vehicle State', 'VEHICLE_STATE', 'vehicle_state', 4),
    ('Drive State', 'DRIVE_STATE', 'drive_state', 4),
    ('Timeout', 'HEARTBEAT_FAILURE', 'heartbeat_failure', 3),
    ('Failure', 'DFMM_FAILURE', 'dfmm_failure_mode', 5),
    ('Drive State Failure', 'DRIVE_STATE_FAILURE', 'drive_state_failure', 5),
    ('EBS Control', 'EBS_CONTROL', 'ebs_control', 3),
    ('AMK Inverter Boot State', 'INVERTER_BOOT_STATE', 'inverter_boot_state', 3),
    ('PC Watchdog Status', 'PC_WATCHDOG', 'pc_watchdog_status', 2),
    ('Precharge State', 'PRECHARGE', 'precharge_state', 3),
    ('AV Initial Check', 'CHECKUP', 'checkup_status', 5),
)


def identifier(name):
    return re.sub(r'[^A-Z0-9]+', '_', name.upper()).strip('_')


def parse_project(path):
    result = {}
    for node in ET.parse(path).findall('.//DataTypes/Type'):
        if node.get('Storage') != 'enum':
            continue
        name = node.attrib['Name']
        members = node.findall('Enum')
        orders = {member.attrib['Name']: int(member.attrib['ContainerOrder'])
                  for member in members}
        if len(orders) != len(members) or len(set(orders.values())) != len(orders):
            raise ValueError(f'{name}: duplicate enum name or ContainerOrder')
        default = node.attrib['Default']
        if default not in orders:
            raise ValueError(f'{name}: missing Default {default}')
        if name in result:
            raise ValueError(f'duplicate enum type {name}')
        result[name] = {member: order - orders[default]
                        for member, order in sorted(orders.items(), key=lambda item: item[1])}
    if not result:
        raise ValueError('project contains no enums')
    return result


def wire_values(values, width):
    mask = (1 << width) - 1
    result = {}
    for name, value in values.items():
        if value < -(1 << (width - 1)) or value > mask:
            raise ValueError(f'{name}={value} does not fit {width} bits')
        wire = value & mask
        if wire in result.values():
            raise ValueError(f'wire value collision at {name}')
        result[name] = wire
    return result


def generate(project, source, template, output):
    provenance = json.loads(Path(source).read_text())
    digest = hashlib.sha256(Path(project).read_bytes()).hexdigest()
    if digest != provenance['sha256']:
        raise ValueError('Project.m1prj does not match source.json sha256')
    if not re.fullmatch(r'[0-9a-f]{40}', provenance['revision']):
        raise ValueError('source.json must pin a full firmware commit')
    enums = parse_project(project)
    constants = []
    header = ['// Generated from Project.m1prj. Do not edit.', '#pragma once',
              '#include <cstdint>', 'namespace uqr_msgs { namespace firmware {',
              f'inline constexpr char kRevision[] = "{provenance["revision"]}";',
              f'inline constexpr char kProjectSha256[] = "{digest}";']
    for type_name, prefix, function, width in DEBUG_FIELDS:
        constants.append(f'# {type_name}, unsigned {width}-bit CAN field.')
        header.append(f'inline const char * {function}_name(uint8_t value) {{\n  switch (value) {{')
        for name, value in wire_values(enums[type_name], width).items():
            # Preserve public ROS spellings while deriving values from the source.
            display_name = name.replace('Reqested', 'Requested')
            public_name = display_name
            if prefix == 'DFMM_FAILURE' and public_name.endswith(' Failure'):
                public_name = public_name[:-8]
            constants.append(f'uint8 {prefix}_{identifier(public_name)}={value}')
            header.append(f'    case {value}: return {json.dumps(display_name)};')
        header.append('    default: return "Unknown";\n  }\n}')
        constants.append('')
    # Keep deprecated source-compatible aliases, deriving their values too.
    for old, current in [('R2D_RES_HV_OFF', 'R2D TS Activation Off'),
                         ('DRIVING_RES_HV_OFF', 'Driving TS Activation Off')]:
        constants.append(f'uint8 DRIVE_STATE_FAILURE_{old}={enums["Drive State Failure"][current]}')
    signed = ['# Signed M1 enum values, relative to each type\'s Default.']
    seen = set()
    for type_name, values in enums.items():
        for name, value in values.items():
            symbol = f'{identifier(type_name)}_{identifier(name)}'
            if symbol in seen:
                raise ValueError(f'constant name collision: {symbol}')
            seen.add(symbol)
            signed.append(f'int32 {symbol}={value}')
            header.append(f'inline constexpr int32_t {symbol} = {value};')
    header.append('inline const char * mission_name(uint8_t value) {\n  switch (value) {')
    for name, value in wire_values(enums['AV Mission'], 3).items():
        header.append(f'    case {value}: return {json.dumps(name)};')
    header.append('    default: return "Unknown";\n  }\n}')
    header.append('} }  // namespace uqr_msgs::firmware')
    out = Path(output)
    (out / 'msg').mkdir(parents=True, exist_ok=True)
    (out / 'include/uqr_msgs').mkdir(parents=True, exist_ok=True)
    (out / 'msg/AVDebug.msg').write_text(Path(template).read_text().replace(
        '@FIRMWARE_CONSTANTS@', '\n'.join(constants)))
    (out / 'msg/FirmwareEnums.msg').write_text('\n'.join(signed) + '\n')
    (out / 'include/uqr_msgs/firmware_enums.hpp').write_text('\n'.join(header) + '\n')
    (out / 'firmware_enums.json').write_text(json.dumps(
        {'source': provenance, 'enums': enums}, indent=2) + '\n')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--project', required=True)
    parser.add_argument('--dump-json', action='store_true')
    parser.add_argument('--source')
    parser.add_argument('--template')
    parser.add_argument('--output')
    args = parser.parse_args()
    if args.dump_json:
        print(json.dumps(parse_project(args.project), indent=2))
    else:
        if not all((args.source, args.template, args.output)):
            parser.error('--source, --template and --output are required for generation')
        generate(args.project, args.source, args.template, args.output)


if __name__ == '__main__':
    main()
