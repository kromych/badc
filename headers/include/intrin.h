/* MSVC compiler intrinsics (<intrin.h>). Only the byte-swap family
** has a CRT export to bind; the remaining intrinsics are
** compiler-generated and stay undeclared so their use fails loudly
** at compile time rather than miscompiling. TODO: lower the
** barrier / bit-scan / mul128 families in the compiler. */
#pragma once

#ifdef _WIN32

#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::_byteswap_ushort, "_byteswap_ushort")
#pragma binding(msvcrt::_byteswap_ulong,  "_byteswap_ulong")
#pragma binding(msvcrt::_byteswap_uint64, "_byteswap_uint64")

unsigned short     _byteswap_ushort(unsigned short value);
unsigned long      _byteswap_ulong(unsigned long value);
unsigned long long _byteswap_uint64(unsigned long long value);

/* Compiler-reordering fence. c5 does not reorder memory accesses
** across calls, so an opaque no-op call carries the required
** ordering. TODO: a fence IR op once pass-level reordering exists. */
static void _ReadWriteBarrier(void) {}

#endif
