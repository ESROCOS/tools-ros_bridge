# H2020 ESROCOS Project
# Company: GMV Aerospace & Defence S.A.U.
# Licence: GPLv2

cmake_minimum_required(VERSION 3.3)

project(ros_bridge)

include($ENV{ESROCOS_CMAKE})

esrocos_init()

add_subdirectory(python)

