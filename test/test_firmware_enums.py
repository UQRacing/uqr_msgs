import importlib.util
import json
from pathlib import Path

import pytest


ROOT = Path(__file__).resolve().parents[1]
SPEC = importlib.util.spec_from_file_location(
    'generate_firmware_enums', ROOT / 'scripts/generate_firmware_enums.py')
enums = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(enums)


def test_real_project_defaults_and_added_states():
    types = enums.parse_project(ROOT / 'firmware/Project.m1prj')
    assert types['Drive State'] == {
        'Emergency': -3, 'Latching Fault': -2, 'HV Lockout': -1, 'Idle': 0,
        'Requesting HV': 1, 'Precharging': 2, 'HV Activated': 3, 'Ready To Drive': 4}
    assert types['PC Watchdog Status'] == {'Emergency': -1, 'Initialisation': 0, 'OK': 1}
    assert types['Derating Driver Lights'] == {
        'Fault': -1, 'Over 3': 0, 'Over 2': 1, 'Over 1': 2, 'Under 1': 3, 'Nominal': 4}
    assert types['Torque Map Level'] == {'Low': -1, 'Medium': 0, 'High': 1}
    assert types['Vehicle State']['Checkup'] == 12
    assert types['Failure']['AV Emergency'] == 14
    assert types['AV Initial Check']['Failed'] == 17
    assert types['Drive State Failure']['R2D TS Activation Off'] == 11
    assert types['Drive State Failure']['Driving TS Activation Off'] == 13
    assert types['AV Mission']['Tech Inspection'] == 1
    assert types['AV Mission']['Track Drive'] == 3


def test_generated_ros_wire_constants_and_provenance(tmp_path):
    enums.generate(ROOT / 'firmware/Project.m1prj', ROOT / 'firmware/source.json',
                   ROOT / 'msg/AVDebug.msg.in', tmp_path)
    msg = (tmp_path / 'msg/AVDebug.msg').read_text()
    for constant in ['DRIVE_STATE_IDLE=0', 'DRIVE_STATE_EMERGENCY=13',
                     'DRIVE_STATE_HV_LOCKOUT=15', 'PC_WATCHDOG_EMERGENCY=3',
                     'PC_WATCHDOG_INITIALISATION=0', 'PC_WATCHDOG_OK=1',
                     'VEHICLE_STATE_CHECKUP=12', 'DFMM_FAILURE_AV_EMERGENCY=14']:
        assert f'uint8 {constant}\n' in msg
    signed = (tmp_path / 'msg/FirmwareEnums.msg').read_text()
    assert 'int32 DRIVE_STATE_EMERGENCY=-3\n' in signed
    assert 'int32 TORQUE_MAP_LEVEL_LOW=-1\n' in signed
    header = (tmp_path / 'include/uqr_msgs/firmware_enums.hpp').read_text()
    assert 'case 1: return "EBS Failure";' in header
    metadata = json.loads((tmp_path / 'firmware_enums.json').read_text())
    assert metadata['source'] == json.loads((ROOT / 'firmware/source.json').read_text())


def test_historical_project_and_shuffled_order(tmp_path):
    project = tmp_path / 'Project.m1prj'
    project.write_text('''<Project><DataTypes>
      <Type Name="AV Mission" Storage="enum" Default="Manual Driving">
        <Enum Name="Tech Inspection" ContainerOrder="3"/>
        <Enum Name="Manual Driving" ContainerOrder="0"/>
        <Enum Name="Track Drive" ContainerOrder="1"/>
      </Type></DataTypes></Project>''')
    assert enums.parse_project(project)['AV Mission']['Track Drive'] == 1
    assert enums.parse_project(project)['AV Mission']['Tech Inspection'] == 3


def test_snapshot_mismatch_fails_build(tmp_path):
    project = tmp_path / 'Project.m1prj'
    project.write_bytes((ROOT / 'firmware/Project.m1prj').read_bytes() + b'\n')
    with pytest.raises(ValueError, match='sha256'):
        enums.generate(project, ROOT / 'firmware/source.json',
                       ROOT / 'msg/AVDebug.msg.in', tmp_path / 'output')


@pytest.mark.parametrize('members,default', [
    ('<Enum Name="Idle" ContainerOrder="0"/>', 'Absent'),
    ('<Enum Name="Idle" ContainerOrder="0"/><Enum Name="Fault" ContainerOrder="0"/>', 'Idle'),
])
def test_malformed_project_fails(tmp_path, members, default):
    project = tmp_path / 'Project.m1prj'
    project.write_text(f'<Project><DataTypes><Type Name="State" Storage="enum" '
                       f'Default="{default}">{members}</Type></DataTypes></Project>')
    with pytest.raises(ValueError):
        enums.parse_project(project)


def test_wire_width_validation():
    assert enums.wire_values({'Emergency': -3, 'Idle': 0}, 4) == {'Emergency': 13, 'Idle': 0}
    with pytest.raises(ValueError, match='collision'):
        enums.wire_values({'Negative': -1, 'Positive': 15}, 4)
    with pytest.raises(ValueError, match='does not fit'):
        enums.wire_values({'Out of range': 16}, 4)
