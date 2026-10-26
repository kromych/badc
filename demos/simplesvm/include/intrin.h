/* <intrin.h> subset for the SimpleSvm driver: the MSVC compiler
 * intrinsics the sources call that badc's bundled <intrin.h> does not
 * provide -- the SVM, control-register, MSR and descriptor families,
 * which the bundled header deliberately leaves undeclared so their use
 * fails at compile time rather than miscompiling. Resolved ahead of the
 * bundled one via -I; #include_next pulls in the bundled header for the
 * intrinsics it does define (__cpuid, __cpuidex, __debugbreak), which
 * are not redefined here. Each addition is expressed over badc's GNU
 * inline asm (AT&T syntax, MS x64 ABI).
 *
 * _sgdt is not here: it is a privileged store that the sources also
 * forward-declare as an EXTERN_C function, so the demo defines it as a
 * real symbol in x64_asm.c rather than an inline, avoiding a
 * static/extern redeclaration clash. */
#pragma once

#if !defined(__x86_64__)
#error "SimpleSvm is x86-64 only"
#endif

#include_next <intrin.h>
#include <stddef.h>

/* Model-specific, control and flags registers. */
static unsigned long long __readmsr(unsigned long Reg) {
    unsigned lo, hi;
    __asm__ volatile("rdmsr" : "=a"(lo), "=d"(hi) : "c"(Reg));
    return ((unsigned long long)hi << 32) | lo;
}
static void __writemsr(unsigned long Reg, unsigned long long Val) {
    __asm__ volatile("wrmsr" ::"c"(Reg), "a"((unsigned)Val), "d"((unsigned)(Val >> 32)));
}
static size_t __readcr0(void) { size_t v; __asm__ volatile("mov %%cr0, %0" : "=r"(v)); return v; }
static size_t __readcr2(void) { size_t v; __asm__ volatile("mov %%cr2, %0" : "=r"(v)); return v; }
static size_t __readcr3(void) { size_t v; __asm__ volatile("mov %%cr3, %0" : "=r"(v)); return v; }
static size_t __readcr4(void) { size_t v; __asm__ volatile("mov %%cr4, %0" : "=r"(v)); return v; }
static void __writeeflags(unsigned long long v) {
    __asm__ volatile("push %0; popfq" ::"r"(v) : "cc");
}

/* Descriptor-table store and segment-limit load. */
static void __sidt(void *Dst) { __asm__ volatile("sidt %0" : "=m"(*(char *)Dst)); }
static unsigned __segmentlimit(unsigned Sel) {
    unsigned l;
    __asm__ volatile("lsl %1, %0" : "=r"(l) : "r"(Sel));
    return l;
}

/* SVM instructions. vmload/vmsave take the VMCB physical address in RAX
 * implicitly; stgi sets the global interrupt flag. */
static void __svm_vmload(size_t Pa) { __asm__ volatile("vmload %%rax" ::"a"(Pa) : "memory"); }
static void __svm_vmsave(size_t Pa) { __asm__ volatile("vmsave %%rax" ::"a"(Pa) : "memory"); }
static void __svm_stgi(void) { __asm__ volatile("stgi" ::: "memory"); }

/* Interrupt-flag clear. */
static void _disable(void) { __asm__ volatile("cli" ::: "memory"); }
