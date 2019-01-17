#!/bin/bash

# H2020 ESROCOS Project
# Company: GMV Aerospace & Defence S.A.U.
# Licence: GPLv2

# Check environment
if [ ! $ROS_ROOT ]; then
    echo "ROS envionrment must be loaded to run the test"
    exit 1
fi
python2 -c "import asn1_value_editor" 2&> /dev/null
if [ ! $? -eq 0 ]; then
    echo "TASTE environment must be loaded with correct PYTHONPATH and PYTHONUSERBASE variables to run the test"
    exit 1
fi

# Clear previous results
echo "Clearing previous results"
#rm -rf ./taste
rm -rf ./bridge
echo "Done."
echo ""

# Build TASTE model
echo "Building TASTE model"
if [ -f taste/binary.c/binaries/x86_partition ]; then
    echo "TASTE model already built, skipping"
else
    cp -rf taste_clean taste
    cd taste
    ./build-script.sh
    if [ ! -f binary.c/binaries/x86_partition ]; then
        echo "ERROR: Partition binary not created"
        exit 2
    elif [ ! -f binary.c/binaries/GUI-ros_bridge ]; then
        echo "ERROR: GUI executable not created"
        exit 2
    fi
    cd ..
fi
echo "Done."
echo ""

# Run bridge generation
echo "Generating bridge component"
export PYTHONPATH=../../python:$PYTHONPATH
../../python/create_ros_bridge taste/binary.c/ ros_bridge bridge
if [ ! $? -eq 0 ] || [ ! -f bridge/ros_bridge.py ]; then
    echo "ERROR: Bridge generation failed"
    exit 3
fi
echo "Done."
echo ""

# Instructions to run test
echo "Bridge component successfully generated."
echo "To test the component:"
echo " - open 4 terminals and ensure that the TASTE and ROS environment is loaded"
echo " - launch ROS core with: roscore"
echo " - launch the test ROS node with: ./rosnode/point_echo.py"
echo " - launch the TASTE test application with: ./taste/binary.c/binaries/x86_partition"
echo " - launch the bridge node with: PYTHONPATH=../../python:\$PYTHONPATH ./bridge/ros_bridge.py"
echo ""






















