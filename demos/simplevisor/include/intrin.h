/* <intrin.h> subset for the VT-x hypervisor sources: the MSVC compiler
 * intrinsics they call, each expressed over badc's GNU inline asm
 * (AT&T syntax, MS x64 ABI). badc's bundled <intrin.h> deliberately
 * leaves the VMX / control-register / MSR families undeclared so their
 * use fails at compile time rather than miscompiling; this demo-local
 * header, resolved ahead of the bundled one via -I, supplies them for
 * windows-x64. The pattern follows demos/include/simd/intrin.h.
 *
 * The status-returning VMX forms report the carry/zero outcome of the
 * instruction as MSVC's intrinsics do: __vmx_vmwrite and friends return
 * 0 on success, 1 on VMfailValid, 2 on VMfailInvalid -- here collapsed
 * to 0/1 via `setna`, which is what the sources test against. */
#pragma once
#include <stddef.h>
#include <stdint.h>

#if !defined(__x86_64__)
#error "SimpleVisor is x86-64 only"
#endif

/* VMX instructions. The physical-address operand is read from memory. */
static unsigned char __vmx_on(unsigned long long *Pa) {
    unsigned char s;
    __asm__ volatile("vmxon %1; setna %0" : "=q"(s) : "m"(*Pa) : "cc", "memory");
    return s;
}
static void __vmx_off(void) { __asm__ volatile("vmxoff" ::: "cc", "memory"); }
static unsigned char __vmx_vmclear(unsigned long long *Pa) {
    unsigned char s;
    __asm__ volatile("vmclear %1; setna %0" : "=q"(s) : "m"(*Pa) : "cc", "memory");
    return s;
}
static unsigned char __vmx_vmptrld(unsigned long long *Pa) {
    unsigned char s;
    __asm__ volatile("vmptrld %1; setna %0" : "=q"(s) : "m"(*Pa) : "cc", "memory");
    return s;
}
static unsigned char __vmx_vmwrite(size_t Field, size_t Value) {
    unsigned char s;
    __asm__ volatile("vmwrite %2, %1; setna %0"
                     : "=q"(s) : "r"(Field), "r"(Value) : "cc", "memory");
    return s;
}
static unsigned char __vmx_vmread(size_t Field, size_t *Value) {
    unsigned char s;
    __asm__ volatile("vmread %2, %1; setna %0"
                     : "=q"(s), "=r"(*Value) : "r"(Field) : "cc", "memory");
    return s;
}
static unsigned char __vmx_vmlaunch(void) {
    unsigned char s;
    __asm__ volatile("vmlaunch; setna %0" : "=q"(s) :: "cc", "memory");
    return s;
}
static unsigned char __vmx_vmresume(void) {
    unsigned char s;
    __asm__ volatile("vmresume; setna %0" : "=q"(s) :: "cc", "memory");
    return s;
}

/* Model-specific, control and debug registers. */
static unsigned long long __readmsr(unsigned long Reg) {
    unsigned lo, hi;
    __asm__ volatile("rdmsr" : "=a"(lo), "=d"(hi) : "c"(Reg));
    return ((unsigned long long)hi << 32) | lo;
}
static void __writemsr(unsigned long Reg, unsigned long long Val) {
    __asm__ volatile("wrmsr" ::"c"(Reg), "a"((unsigned)Val), "d"((unsigned)(Val >> 32)));
}
static size_t __readcr0(void) { size_t v; __asm__ volatile("mov %%cr0, %0" : "=r"(v)); return v; }
static size_t __readcr3(void) { size_t v; __asm__ volatile("mov %%cr3, %0" : "=r"(v)); return v; }
static size_t __readcr4(void) { size_t v; __asm__ volatile("mov %%cr4, %0" : "=r"(v)); return v; }
static void __writecr0(size_t v) { __asm__ volatile("mov %0, %%cr0" ::"r"(v)); }
static void __writecr3(size_t v) { __asm__ volatile("mov %0, %%cr3" ::"r"(v)); }
static void __writecr4(size_t v) { __asm__ volatile("mov %0, %%cr4" ::"r"(v)); }
static size_t __readdr(unsigned n) {
    size_t v = 0;
    if (n == 7) { __asm__ volatile("mov %%dr7, %0" : "=r"(v)); }
    return v;
}
static unsigned long long __readeflags(void) {
    unsigned long long v;
    __asm__ volatile("pushfq; pop %0" : "=r"(v));
    return v;
}
static void __writeeflags(unsigned long long v) {
    __asm__ volatile("push %0; popfq" ::"r"(v) : "cc");
}

/* Descriptor-table and segment-limit instructions. */
static void __sidt(void *Dst) { __asm__ volatile("sidt %0" : "=m"(*(char *)Dst)); }
static void __lidt(void *Src) { __asm__ volatile("lidt %0" ::"m"(*(char *)Src)); }
static void __lgdt(void *Src) { __asm__ volatile("lgdt %0" ::"m"(*(char *)Src)); }
static void _sgdt(void *Dst) { __asm__ volatile("sgdt %0" : "=m"(*(char *)Dst)); }
static void _str(unsigned short *Dst) { __asm__ volatile("str %0" : "=m"(*Dst)); }
static void _sldt(unsigned short *Dst) { __asm__ volatile("sldt %0" : "=m"(*Dst)); }
static unsigned __segmentlimit(unsigned Sel) {
    unsigned l;
    __asm__ volatile("lsl %1, %0" : "=r"(l) : "r"(Sel));
    return l;
}

/* Extended-control-register write (XCR0 setup for the guest). */
static void _xsetbv(unsigned Idx, unsigned long long Val) {
    __asm__ volatile("xsetbv" ::"c"(Idx), "a"((unsigned)Val), "d"((unsigned)(Val >> 32)));
}

/* Cache and block-store. */
static void __wbinvd(void) { __asm__ volatile("wbinvd" ::: "memory"); }
static void __stosq(unsigned long long *Dst, unsigned long long Val, size_t Count) {
    __asm__ volatile("rep stosq" : "+D"(Dst), "+c"(Count) : "a"(Val) : "memory");
}

/* CPU identification. */
static void __cpuidex(int Info[4], int Leaf, int Sub) {
    unsigned a, b, c, d;
    __asm__ volatile("cpuid" : "=a"(a), "=b"(b), "=c"(c), "=d"(d) : "a"(Leaf), "c"(Sub));
    Info[0] = (int)a; Info[1] = (int)b; Info[2] = (int)c; Info[3] = (int)d;
}
static void __cpuid(int Info[4], int Leaf) { __cpuidex(Info, Leaf, 0); }

/* Bit scan over the GCC count-trailing/leading-zero builtins. */
static unsigned char _BitScanForward64(unsigned long *Index, unsigned long long Mask) {
    if (!Mask) return 0;
    *Index = (unsigned long)__builtin_ctzll(Mask);
    return 1;
}
static unsigned char _BitScanReverse64(unsigned long *Index, unsigned long long Mask) {
    if (!Mask) return 0;
    *Index = (unsigned long)(63 - __builtin_clzll(Mask));
    return 1;
}

/* Return-address slot, used by the launch fix-up path. Assumes a frame
 * pointer is set up, which the demo's build (-O off for this unit) keeps. */
static void *_AddressOfReturnAddress(void) {
    return (void *)((char *)__builtin_frame_address(0) + 8);
}

static long _InterlockedIncrement(volatile long *P) {
    return __atomic_add_fetch(P, 1, __ATOMIC_SEQ_CST);
}
