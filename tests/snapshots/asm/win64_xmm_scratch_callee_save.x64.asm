
win64_xmm_scratch_callee_save.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movabsq	$0x4008000000000000, %rdi # imm = 0x4008000000000000
               	movabsq	$0x4010000000000000, %r8 # imm = 0x4010000000000000
               	movabsq	$0x4014000000000000, %rdx # imm = 0x4014000000000000
               	movabsq	$0x4018000000000000, %rsi # imm = 0x4018000000000000
               	movq	%r8, %xmm15
               	movq	%rdi, %xmm0
               	mulsd	%xmm15, %xmm0
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movq	%rdx, %xmm14
               	movq	%rsi, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	cvttsd2si	%xmm0, %rdx
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movapd	%xmm0, %xmm14
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	cvttsd2si	%xmm0, %rax
               	movslq	%edx, %rcx
               	cmpq	$0x2c, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movslq	%eax, %rax
               	cmpq	$0x59, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movabsq	$0x4024000000000000, %rcx # imm = 0x4024000000000000
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	movq	%rax, %xmm0
               	mulsd	%xmm15, %xmm0
               	movq	%rcx, %xmm14
               	movq	%rdx, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	cvttsd2si	%xmm0, %rdx
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movq	%rcx, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	cvttsd2si	%xmm0, %rax
               	movslq	%edx, %rcx
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movslq	%eax, %rax
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorq	%rax, %rax
               	retq
