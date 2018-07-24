#!/bin/bash

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
    elif [ ! -f binary.c/binaries/GUI-joints_bridge ]; then
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
../../python/create_ros_bridge taste/binary.c/ joints_bridge bridge
if [ ! $? -eq 0 ] || [ ! -f bridge/joints_bridge.py ]; then
    echo "ERROR: Bridge generation failed"
    exit 3
fi
echo "Done."
echo ""

# Instructions to run test
echo "Bridge component successfully generated."
echo "To test the component, use the RVIZ configuration test_bridge.lauch, provided"
echo "in the Git repo https://spass-git-ext.gmv.com/esrocos/ros-ur5_robot."
echo " - open 4 terminals and ensure that the TASTE and ROS environment is loaded"
echo " - launch ROS core with: roscore"
echo " - cd to the catkin workspace, and launch RVIZ with: roslaunch src/ur5_robot/launch/test_bridge.launch"
echo " - launch the TASTE x86_partition binary with: taste/binary.c/binaries/x86_partition"
echo " - launch the bridge node with: PYTHONPATH=../../python:\$PYTHONPATH ./bridge/joints_bridge.py"
echo ""






















