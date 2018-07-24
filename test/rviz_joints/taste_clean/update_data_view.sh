export FILES="
$AUTOPROJ_CURRENT_ROOT/install/types/ros/taste-extended.asn \
$AUTOPROJ_CURRENT_ROOT/install/types/ros/std_msgs.asn \
$AUTOPROJ_CURRENT_ROOT/install/types/ros/geometry_msgs.asn \
$AUTOPROJ_CURRENT_ROOT/install/types/ros/sensor_msgs.asn \
$AUTOPROJ_CURRENT_ROOT/install/types/ros/userdefs-std_msgs.asn \
$AUTOPROJ_CURRENT_ROOT/install/types/ros/userdefs-geometry_msgs.asn \
$AUTOPROJ_CURRENT_ROOT/install/types/ros/userdefs-sensor_msgs.asn \
"
echo "Updating DataView.aadl"
taste-update-data-view $FILES
