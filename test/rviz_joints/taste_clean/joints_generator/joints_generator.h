/* This file was generated automatically: DO NOT MODIFY IT ! */

/* Declaration of the functions that have to be provided by the user */

#ifndef __USER_CODE_H_joints_generator__
#define __USER_CODE_H_joints_generator__

#include "C_ASN1_Types.h"

#ifdef __cplusplus
extern "C" {
#endif

void joints_generator_startup();

void joints_generator_PI_step();

extern void joints_generator_RI_ur5_joints(const asn1SccSensor_msgs_JointState *);

#ifdef __cplusplus
}
#endif


#endif
