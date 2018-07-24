/* User code: This file will not be overwritten by TASTE. */

#include "joints_generator.h"
#include <string.h>

#define SET_STRING(ASNVAR, STRING) \
    { \
        strcpy((char*)&ASNVAR.arr, (char*)STRING); \
        ASNVAR.nCount = strlen(STRING); \
    }

asn1SccSensor_msgs_JointState js;


void joints_generator_startup()
{
    char* names[] = {"shoulder_pan_joint", "shoulder_lift_joint", "elbow_joint", "wrist_1_joint", "wrist_2_joint", "wrist_3_joint"};
    
    SET_STRING(js.header.frame_id, "None");
    js.header.seq = 0;
    js.header.stamp.secs = 0.0;
    js.header.stamp.nsecs = 0.0;
    
    js.name_value.nCount = 6;
    js.position.nCount = 6;
    js.velocity.nCount = 6;
    js.effort.nCount = 6;
    
    for (int i = 0; i < 6; i++)
    {
        SET_STRING(js.name_value.arr[i], names[i]);
        js.position.arr[i] = 0.0;
        js.velocity.arr[i] = 0.0;
        js.effort.arr[i] = 0.0;
    }
}

void joints_generator_PI_step()
{
    static int count = 0;
    
    for (int i = 0; i < 6; i++)
    {
        js.position.arr[i] = 0.1 * count;
    }
    
    count++;
    
    joints_generator_RI_ur5_joints(&js);
}

