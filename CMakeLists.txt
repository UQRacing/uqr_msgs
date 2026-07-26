cmake_minimum_required(VERSION 3.5)

project(uqr_msgs)

# Default to C++14
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
endif()
if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

find_package(ament_cmake REQUIRED)
find_package(builtin_interfaces REQUIRED)
find_package(rosidl_default_generators REQUIRED)
find_package(std_msgs REQUIRED)
find_package(geometry_msgs REQUIRED)
find_package(sensor_msgs REQUIRED)

set(msg_files
  "msg/AVDebug.msg"
  "msg/AVStatus.msg"
  "msg/AccumulatorStatus.msg"
  "msg/AmkActualValues1.msg"
  "msg/AmkActualValues2.msg"
  "msg/AmkSetpoints.msg"
  "msg/AmkSetpointsPair.msg"
  "msg/C125Status.msg"
  "msg/CmuCells.msg"
  "msg/Cone3D.msg"
  "msg/DepthImage.msg"
  "msg/M1Status.msg"
  "msg/Map.msg"
  "msg/NNConeDetection.msg"
  "msg/NNConeDetections.msg"
  "msg/P14Output.msg"
  "msg/P14Status.msg"
  "msg/Pdm15Output.msg"
  "msg/Pdm15Status.msg"
  "msg/Perception.msg"
  "msg/Rect2D.msg"
  "msg/ResStatus.msg"
  "msg/Safety.msg"
  "msg/VAMSoundRequest.msg"
)

rosidl_generate_interfaces(${PROJECT_NAME}
  ${msg_files}
  DEPENDENCIES builtin_interfaces std_msgs geometry_msgs sensor_msgs
  ADD_LINTER_TESTS
)

ament_export_dependencies(rosidl_default_runtime)

ament_package()
