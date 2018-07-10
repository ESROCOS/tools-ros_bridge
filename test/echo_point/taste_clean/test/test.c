/* User code: This file will not be overwritten by TASTE. */

#include "test.h"

asn1SccGeometry_msgs_Point point64;

void test_startup()
{
    point64.x = 0.0;
    point64.y = 0.0;
    point64.z = 0.0;
}

void test_PI_run()
{
    printf("send point64 %f %f %f \n", point64.x, point64.y, point64.z);
    test_RI_pointToRos(&point64);
    point64.x++; point64.y++; point64.z++; 
}

void test_PI_point32fromRos(const asn1SccGeometry_msgs_Point32 *IN_pt)
{
    printf("recv point32 %f %f %f \n", IN_pt->x, IN_pt->y, IN_pt->z);
}

