/* AMD64 assembly routines of SimpleVisor, translated from the upstream
 * MASM modules (shvvmxhvx64.asm and nt/shvosx64.asm) into badc naked
 * functions with GNU inline asm. badc's assembler path is GNU/AT&T
 * syntax; a __attribute__((naked)) function emits its asm body with no
 * prologue or epilogue, which is what these routines require. The MS
 * x64 ABI passes the first two integer arguments in RCX and RDX.
 *
 * The VMENTRY and context-restore paths run only inside a live
 * hypervisor; this demo never loads one, so these are built and linked
 * for structure, not executed.
 *
 * Copyright (c) Alex Ionescu. All rights reserved. (2-clause BSD; see
 * demos/simplevisor/README.md.) */
#include "shv.h"

struct _EXCEPTION_RECORD;

/* VMEXIT entry (shvvmxhvx64.asm:ShvVmxEntry). Saves RCX, points RCX at
 * the on-stack save area past the return address and the pushed RCX,
 * captures the register state, then tail-jumps into the C handler. */
__attribute__((naked)) VOID ShvVmxEntry(VOID) {
    __asm__ volatile("push %rcx\n\t"
                     "lea 8(%rsp), %rcx\n\t"
                     "call ShvOsCaptureContext\n\t"
                     "jmp ShvVmxEntryHandler\n\t");
}

/* nt/shvosx64.asm:ShvVmxCleanup -- reload DS/ES from arg1 (CX) and FS
 * from arg2 (DX) after an iretq cleared their RPL bits. */
__attribute__((naked)) VOID ShvVmxCleanup(UINT16 Data, UINT16 Teb) {
    (void)Data;
    (void)Teb;
    __asm__ volatile("mov %cx, %ds\n\t"
                     "mov %cx, %es\n\t"
                     "mov %dx, %fs\n\t"
                     "ret\n\t");
}

/* Canonical windows-x64 CONTEXT layout (ntint.h mirrors it). The restore
 * routine below reaches these by numeric displacement, so a divergence
 * must fail at compile time rather than restore the wrong register. */
_Static_assert(__builtin_offsetof(CONTEXT, EFlags) == 0x44, "CONTEXT.EFlags");
_Static_assert(__builtin_offsetof(CONTEXT, Rax) == 0x78, "CONTEXT.Rax");
_Static_assert(__builtin_offsetof(CONTEXT, Rsp) == 0x98, "CONTEXT.Rsp");
_Static_assert(__builtin_offsetof(CONTEXT, Rip) == 0xf8, "CONTEXT.Rip");
_Static_assert(__builtin_offsetof(CONTEXT, Xmm0) == 0x1a0, "CONTEXT.Xmm0");

/* nt/shvosx64.asm:ShvOsRestoreContext2 -- restore the full register file
 * from the CONTEXT in arg1 (RCX) and resume at CxRip. The second
 * argument (an EXCEPTION_RECORD*) is unused, matching the upstream
 * RtlRestoreContext-shaped signature. */
__attribute__((naked)) VOID ShvOsRestoreContext2(PCONTEXT ContextRecord,
                                                 struct _EXCEPTION_RECORD *ExceptionRecord) {
    (void)ContextRecord;
    (void)ExceptionRecord;
    __asm__ volatile("movaps 0x1a0(%rcx), %xmm0\n\t"
                     "movaps 0x1b0(%rcx), %xmm1\n\t"
                     "movaps 0x1c0(%rcx), %xmm2\n\t"
                     "movaps 0x1d0(%rcx), %xmm3\n\t"
                     "movaps 0x1e0(%rcx), %xmm4\n\t"
                     "movaps 0x1f0(%rcx), %xmm5\n\t"
                     "movaps 0x200(%rcx), %xmm6\n\t"
                     "movaps 0x210(%rcx), %xmm7\n\t"
                     "movaps 0x220(%rcx), %xmm8\n\t"
                     "movaps 0x230(%rcx), %xmm9\n\t"
                     "movaps 0x240(%rcx), %xmm10\n\t"
                     "movaps 0x250(%rcx), %xmm11\n\t"
                     "movaps 0x260(%rcx), %xmm12\n\t"
                     "movaps 0x270(%rcx), %xmm13\n\t"
                     "movaps 0x280(%rcx), %xmm14\n\t"
                     "movaps 0x290(%rcx), %xmm15\n\t"
                     "ldmxcsr 0x118(%rcx)\n\t"
                     "mov 0x78(%rcx), %rax\n\t"
                     "mov 0x88(%rcx), %rdx\n\t"
                     "mov 0xb8(%rcx), %r8\n\t"
                     "mov 0xc0(%rcx), %r9\n\t"
                     "mov 0xc8(%rcx), %r10\n\t"
                     "mov 0xd0(%rcx), %r11\n\t"
                     "mov 0x90(%rcx), %rbx\n\t"
                     "mov 0xa8(%rcx), %rsi\n\t"
                     "mov 0xb0(%rcx), %rdi\n\t"
                     "mov 0xa0(%rcx), %rbp\n\t"
                     "mov 0xd8(%rcx), %r12\n\t"
                     "mov 0xe0(%rcx), %r13\n\t"
                     "mov 0xe8(%rcx), %r14\n\t"
                     "mov 0xf0(%rcx), %r15\n\t"
                     "cli\n\t"
                     "push 0x44(%rcx)\n\t"
                     "popfq\n\t"
                     "mov 0x98(%rcx), %rsp\n\t"
                     "push 0xf8(%rcx)\n\t"
                     "mov 0x80(%rcx), %rcx\n\t"
                     "ret\n\t");
}
