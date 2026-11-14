/* The Arm C Language Extensions' <arm_sve.h> on AArch64: the sizeless SVE
 * vector and predicate types over the builtin type names. */
#ifndef BADC_ARM_SVE_H
#define BADC_ARM_SVE_H

#ifndef __aarch64__
#error "arm_sve.h requires an AArch64 target"
#endif

#include <stdint.h>
#include <stdbool.h>

typedef __SVInt8_t svint8_t;
typedef __SVInt16_t svint16_t;
typedef __SVInt32_t svint32_t;
typedef __SVInt64_t svint64_t;
typedef __SVUint8_t svuint8_t;
typedef __SVUint16_t svuint16_t;
typedef __SVUint32_t svuint32_t;
typedef __SVUint64_t svuint64_t;
typedef __SVFloat16_t svfloat16_t;
typedef __SVBfloat16_t svbfloat16_t;
typedef __SVFloat32_t svfloat32_t;
typedef __SVFloat64_t svfloat64_t;
typedef __SVBool_t svbool_t;

#endif
