## H2020 ESROCOS Project
## Company: GMV Aerospace & Defence S.A.U.
## Licence: GPLv2
##
## Mako template to generate the Orogen file for a ROCK bridge component.
##
<%
    import os
    from rosBridgeModule import typeConvert
    
    import rospkg
    rospack = rospkg.RosPack()
%>\
#!/usr/bin/env python2
# Generated from ${os.path.basename(context._with_template.uri)}

from __future__ import absolute_import

import threading, time, sys, os, ctypes
import rospy, rosmsg, rospkg, genpy
from rosBridgeModule import typeConvert


# Get directory of current script
scriptDir = os.path.dirname(os.path.abspath(__file__))

# Add to the Python path the directory containing the code from TASTE
tasteDir = os.path.join(scriptDir, 'tasteInterface')
sys.path.append(tasteDir)

# Load Deployment View information
import DV

# Load PythonAccess.so library generated by TASTE, and create global definitions
PythonAccess = ctypes.cdll.LoadLibrary(os.path.join(tasteDir, 'PythonAccess.so'))

OpenMsgQueueForReading = PythonAccess.OpenMsgQueueForReading
OpenMsgQueueForReading.restype = ctypes.c_int
CloseMsgQueue =  PythonAccess.CloseMsgQueue
GetMsgQueueBufferSize = PythonAccess.GetMsgQueueBufferSize
GetMsgQueueBufferSize.restype = ctypes.c_int
RetrieveMessageFromQueue = PythonAccess.RetrieveMessageFromQueue
RetrieveMessageFromQueue.restype = ctypes.c_int

# Import the Data View information
import dataview_uniq_asn

# Read TASTE port identifiers 
% for iface in iv.list_interfaces(function):
i_${iface} = ctypes.c_int.in_dll(PythonAccess, "ii_${iface}").value
% endfor

# Import backend for RIs (with send functions)
% for ri in iv.list_ri(function):
import ${ri}_backend
% endfor

# Import data model information
import datamodel

# Import opengeode to parse types information
from opengeode import Asn1scc as asn1scc

# Import ROS type packages
% for ri in iv.list_interfaces(function):
<%
    param = iv.get_in_param_idx(function, ri, 0)
    paramType = iv.get_in_param_type(function, ri, param)
    (_, pkgName, _) = typeConvert.find_ros_type(rospack, paramType)
%>\
import ${pkgName}.msg
% endfor

# Debug flag
DebugBridge = False


# Polling thread to read message queue from TASTE
class Poll_${function}(threading.Thread):
    def run(self):
        self._bDie = False
        while True:
            if self._bDie:
                return
            self._msgQueue = OpenMsgQueueForReading(str(os.geteuid()) + "_${function}_PI_Python_queue")
            if (self._msgQueue != -1): break
            print "Communication channel over %d_${function}_PI_Python_queue not established yet...\n" % os.geteuid()
            time.sleep(1)
        bufferSize = GetMsgQueueBufferSize(self._msgQueue)
        self._pMem = ctypes.create_string_buffer(bufferSize).raw
        while not self._bDie:
            self.messageReceivedType = RetrieveMessageFromQueue(self._msgQueue, bufferSize, self._pMem)
            if self.messageReceivedType == -1:
                time.sleep(0.01)
                continue
            self.forward_to_ros()


    def forward_to_ros(self):
        '''Called from Poll thread to forward messages to ROS.'''
% for pi in iv.list_pi(function):
<%
    param = iv.get_in_param_idx(function, pi, 0)
    paramType = iv.get_in_param_type(function, pi, param)
%>\
        ${'' if loop.first else 'el'}if self.messageReceivedType == i_${pi}:
            backup = self._pMem
            # Read the data for param pt
            var_pt = dataview_uniq_asn.${paramType}()
            var_pt.SetData(self._pMem)
            forward_to_ros_${pi}(var_pt.GSER())
            # Revert the pointer to start of the data
            self._pMem = backup
% endfor
        else:
            print('Unexpected message received at ${function} queue.')



# Functions to forward PIs from TASTE to ROS
% for pi in iv.list_pi(function):
<%
    param = iv.get_in_param_idx(function, pi, 0)
    paramType = iv.get_in_param_type(function, pi, param)
    (_, _, typeName) = typeConvert.find_ros_type(rospack, paramType)
%>\
def forward_to_ros_${pi}(gser):
    '''Forward ${pi} PI to ROS'''
    rosObj = typeConvert.get_ros_message_object('${typeName}')
    rosObj = typeConvert.gser_to_rosmsg(gser, rosObj)
    if DebugBridge:
        print('forward_to_ros_${pi} (publish) \n{}'.format(gser))
    publisher_${pi}.publish(rosObj)
% endfor



# Functions to forward RIs from ROS to TASTE
% for ri in iv.list_ri(function):
<%
    param = iv.get_in_param_idx(function, pi, 0)
    paramType = iv.get_in_param_type(function, pi, param)
    (_, _, typeName) = typeConvert.find_ros_type(rospack, paramType)
%>\
def forward_to_taste_${ri}(data):
    '''Forward ${ri} RI to TASTE'''
    gser = typeConvert.rosmsg_to_gser(data)
    if DebugBridge:
        print('forward_to_taste_${ri} \n{}'.format(gser))
    ${ri}_backend.send_${ri}_VN(gser)
% endfor



# ROS publishers for PIs
% for pi in iv.list_pi(function):
publisher_${pi} = None
% endfor


def main():
    # See asn1_value_editor/Scenario.py
    # Parse the dataview.asn to get the Python AST
    dataView = asn1scc.parse_asn1([os.path.join(tasteDir, 'dataview-uniq.asn')],
                          rename_policy=asn1scc.ASN1.RenameOnlyConflicting,
                          ast_version=asn1scc.ASN1.UniqueEnumeratedNames,
                          flags=[asn1scc.ASN1.AstOnly])
    # set the ASN.AST into the backend modules, needed to convert VN, 
    # and configure for message queue
% for ri in iv.list_ri(function):
    ${ri}_backend.ASN1_AST = dataView.types
    ${ri}_backend.setMsgQ()
% endfor

    # Start the ROS node
    print('initializing ROS node')
    rospy.init_node('${function}', anonymous=True)

    # Create ROS publishers for the PIs
% for pi in iv.list_pi(function):
<%
    param = iv.get_in_param_idx(function, pi, 0)
    paramType = iv.get_in_param_type(function, pi, param)
    (_, pkgName, typeName) = typeConvert.find_ros_type(rospack, paramType)
    rosObj = typeConvert.get_ros_message_object(typeName)
    pythonType = type(rosObj)
%>\
    print('creating ROS publisher ${pi} of type ${pkgName}.msg.${pythonType.__name__}')
    global publisher_${pi}
    publisher_${pi} = rospy.Publisher('${pi}', ${pkgName}.msg.${pythonType.__name__}, queue_size=10)
% endfor

    # Create ROS subscribers for the RIs
% for ri in iv.list_ri(function):
<%
    param = iv.get_in_param_idx(function, ri, 0)
    paramType = iv.get_in_param_type(function, ri, param)
    (_, pkgName, typeName) = typeConvert.find_ros_type(rospack, paramType)
    rosObj = typeConvert.get_ros_message_object(typeName)
    pythonType = type(rosObj)
%>\
    print('creating ROS subscriber ${ri} of type ${pkgName}.msg.${pythonType.__name__}')
    rospy.Subscriber('${ri}', ${pkgName}.msg.${pythonType.__name__}, forward_to_taste_${ri})
% endfor
    
    # Start TASTE polling thread
    print('starting TASTE polling thread')
    poll_ros_bridge = Poll_ros_bridge()
    poll_ros_bridge.start()

    # Run until node stopped
    try:
        print('bridge is running')
        rospy.spin()
    finally:
        poll_ros_bridge._bDie = True
        poll_ros_bridge.join()



if __name__ == '__main__':
    main()