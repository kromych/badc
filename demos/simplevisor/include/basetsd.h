/* <basetsd.h> subset: the fixed-width and pointer-width typedefs the
 * SimpleVisor sources take from the Windows SDK. badc ships no WDK/SDK
 * basetsd.h, so the demo supplies the names it uses, mapped onto the
 * C99 <stdint.h> types (LLP64: long is 32-bit on windows-x64). */
#pragma once
#include <stdint.h>
#include <stddef.h>

typedef int8_t   INT8;
typedef int16_t  INT16;
typedef int32_t  INT32;
typedef int64_t  INT64;
typedef uint8_t  UINT8;
typedef uint16_t UINT16;
typedef uint32_t UINT32;
typedef uint64_t UINT64;

typedef intptr_t  INT_PTR;
typedef uintptr_t UINT_PTR;
typedef intptr_t  LONG_PTR;
typedef uintptr_t ULONG_PTR;
typedef uintptr_t SIZE_T;
typedef intptr_t  SSIZE_T;

typedef unsigned long  ULONG;
typedef unsigned short USHORT;
typedef unsigned char  UCHAR;
