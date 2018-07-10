#!/usr/bin/env python2

import rospy, rosmsg
from importlib import import_module
import geometry_msgs.msg


publisher = None


def echo_point(point):
    print('callback echo_point \n{}'.format(point))
    echo = geometry_msgs.msg.Point32(1000+point.x, 1000+point.y, 1000+point.z)
    publisher.publish(echo)


def main():
    # Start the ROS node
    print('initializing ROS node point_echo')
    rospy.init_node('point_echo', anonymous=True)

    # Create ROS publishers for the PIs
    global publisher
    print("creating publisher 'point32fromRos' of type 'geometry_msgs.msg.Point32'")
    publisher = rospy.Publisher('point32fromRos', geometry_msgs.msg.Point32, queue_size=10)

    # Create ROS subscribers for the RIs
    print("creating subscriber 'pointToRos' of type 'geometry_msgs.msg.Point'")
    rospy.Subscriber('pointToRos', geometry_msgs.msg.Point, echo_point)
    
    # Run until node stopped
    print('running')
    rospy.spin()


if __name__ == '__main__':
    main()
