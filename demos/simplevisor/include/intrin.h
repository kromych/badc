/* <intrin.h> for the VT-x hypervisor sources. badc lowers the MSVC
 * intrinsics they call (VMX, control and debug registers, MSRs, descriptor
 * tables, __cpuid, the Interlocked and bit-scan families) itself; this
 * header, resolved ahead of the bundled one via -I, adds the three
 * helpers upstream takes from its MASM module nt/shvosx64.asm instead, over
 * GNU inline asm (AT&T syntax). */
#pragma once
#include <stddef.h>
#include <stdint.h>

#if !defined(__x86_64__)
#error "SimpleVisor is x86-64 only"
#endif

static void __lgdt(void *Src) { __asm__ volatile("lgdt %0" ::"m"(*(char *)Src)); }
static void _str(unsigned short *Dst) { __asm__ volatile("str %0" : "=m"(*Dst)); }
static void _sldt(unsigned short *Dst) { __asm__ volatile("sldt %0" : "=m"(*Dst)); }
