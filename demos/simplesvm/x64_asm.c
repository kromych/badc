/* AMD64 assembly routines of SimpleSvm, translated from the upstream
 * MASM module (x64.asm) into badc naked functions with GNU inline asm.
 * badc's assembler path is GNU/AT&T syntax; a __attribute__((naked))
 * function emits its asm body with no prologue or epilogue, which is
 * what these routines require. The MS x64 ABI passes the first integer
 * argument in RCX.
 *
 * SvLaunchVm runs the guest and dispatches #VMEXIT; it runs only inside
 * a live hypervisor, which this demo never starts, so it is built and
 * linked for structure, not executed. _sgdt is a privileged store the
 * sources forward-declare as an EXTERN_C function.
 *
 * Copyright (c) 2017-2019 Satoshi Tanda. (MIT; see
 * demos/simplesvm/README.md.) */

typedef void VOID_;
typedef void *PVOID;

/* SvHandleVmExit (SimpleSvm.c) is tail-called from the loop below; the
 * assembler resolves the name at link time. */

/* x64.asm:SvLaunchVm -- switch to the host stack (HostRsp in RCX), then
 * loop: VMLOAD/VMRUN/VMSAVE the guest VMCB, save the guest GPRs and
 * volatile XMM registers, call SvHandleVmExit with (VpData in RCX,
 * GuestRegisters in RDX), and resume until the handler returns nonzero.
 * On exit, restore the guest stack and return past the CPUID that
 * triggered the unload, with ECX = 'SSVM'. The MASM unwind directives
 * (.pushframe/.allocstack/.endprolog) carry no code and are dropped. */
__attribute__((naked)) void SvLaunchVm(PVOID HostRsp) {
    (void)HostRsp;
    __asm__ volatile(
        "mov %rcx, %rsp\n\t"
    "1:\n\t"
        "mov (%rsp), %rax\n\t"
        "vmload %rax\n\t"
        "vmrun %rax\n\t"
        "vmsave %rax\n\t"
        "sub $0x190, %rsp\n\t"       /* KTRAP_FRAME_SIZE */
        "push %rax\n\t"              /* PUSHAQ: save guest GPRs */
        "push %rcx\n\t"
        "push %rdx\n\t"
        "push %rbx\n\t"
        "push $-1\n\t"              /* dummy for RSP */
        "push %rbp\n\t"
        "push %rsi\n\t"
        "push %rdi\n\t"
        "push %r8\n\t"
        "push %r9\n\t"
        "push %r10\n\t"
        "push %r11\n\t"
        "push %r12\n\t"
        "push %r13\n\t"
        "push %r14\n\t"
        "push %r15\n\t"
        "mov %rsp, %rdx\n\t"         /* RDX <= GuestRegisters */
        "mov 0x220(%rsp), %rcx\n\t"  /* RCX <= VpData (8*18 + KTRAP_FRAME_SIZE) */
        "sub $0x80, %rsp\n\t"        /* homing space + volatile XMM save */
        "movaps %xmm0, 0x20(%rsp)\n\t"
        "movaps %xmm1, 0x30(%rsp)\n\t"
        "movaps %xmm2, 0x40(%rsp)\n\t"
        "movaps %xmm3, 0x50(%rsp)\n\t"
        "movaps %xmm4, 0x60(%rsp)\n\t"
        "movaps %xmm5, 0x70(%rsp)\n\t"
        "call SvHandleVmExit\n\t"
        "movaps 0x70(%rsp), %xmm5\n\t"
        "movaps 0x60(%rsp), %xmm4\n\t"
        "movaps 0x50(%rsp), %xmm3\n\t"
        "movaps 0x40(%rsp), %xmm2\n\t"
        "movaps 0x30(%rsp), %xmm1\n\t"
        "movaps 0x20(%rsp), %xmm0\n\t"
        "add $0x80, %rsp\n\t"
        "test %al, %al\n\t"          /* POPAQ does not alter flags */
        "pop %r15\n\t"
        "pop %r14\n\t"
        "pop %r13\n\t"
        "pop %r12\n\t"
        "pop %r11\n\t"
        "pop %r10\n\t"
        "pop %r9\n\t"
        "pop %r8\n\t"
        "pop %rdi\n\t"
        "pop %rsi\n\t"
        "pop %rbp\n\t"
        "pop %rbx\n\t"              /* dummy for RSP */
        "pop %rbx\n\t"
        "pop %rdx\n\t"
        "pop %rcx\n\t"
        "pop %rax\n\t"
        "jnz 2f\n\t"                 /* ExitVm != 0 -> terminate */
        "add $0x190, %rsp\n\t"
        "jmp 1b\n\t"
    "2:\n\t"
        "mov %rcx, %rsp\n\t"         /* restore guest stack */
        "mov $0x5353564d, %ecx\n\t"  /* 'SSVM' */
        "jmp *%rbx\n\t"              /* return past the CPUID */
    );
}

/* _sgdt -- store the GDTR (10 bytes on long mode) to [RCX]. */
__attribute__((naked)) void _sgdt(PVOID Descriptor) {
    (void)Descriptor;
    __asm__ volatile("sgdt (%rcx)\n\tret\n\t");
}
