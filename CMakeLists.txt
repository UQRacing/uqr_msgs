cmake_minimum_required(VERSION 3.0.0)
project(uqr_msgs)

find_package(catkin REQUIRED COMPONENTS
        cmake_modules
        geometry_msgs
        message_generation
        std_msgs)

add_message_files(FILES
        CmdVel.msg
        Safety.msg
        PPUnknownDebug.msg
        ConePair.msg
)

generate_messages(DEPENDENCIES std_msgs geometry_msgs)

catkin_package(CATKIN_DEPENDS message_runtime)
