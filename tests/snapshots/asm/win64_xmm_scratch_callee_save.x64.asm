
win64_xmm_scratch_callee_save.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<mix>:
               	mulsd	%xmm3, %xmm2
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movapd	%xmm4, %xmm14
               	movapd	%xmm5, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	retq

<make>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	mulsd	%xmm3, %xmm2
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm1
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movapd	%xmm4, %xmm14
               	movapd	%xmm5, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	leaq	-0x8(%rbp), %rax
               	cvttsd2si	%xmm1, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movapd	%xmm1, %xmm14
               	movq	%rcx, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	cvttsd2si	%xmm0, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movabsq	$0x3ff0000000000000, %rdi # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rsi # imm = 0x4000000000000000
               	movabsq	$0x4008000000000000, %rdx # imm = 0x4008000000000000
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	movabsq	$0x4014000000000000, %r8 # imm = 0x4014000000000000
               	movabsq	$0x4018000000000000, %r9 # imm = 0x4018000000000000
               	movq	%rdi, %xmm0
               	movq	%rsi, %xmm1
               	movq	%rdx, %xmm2
               	movq	%rcx, %xmm3
               	movq	%r8, %xmm4
               	movq	%r9, %xmm5
               	callq	<addr>
               	movq	%rax, -0x58(%rbp)
               	leaq	-0x58(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x59, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4024000000000000, %rdi # imm = 0x4024000000000000
               	movabsq	$0x3ff0000000000000, %rsi # imm = 0x3FF0000000000000
               	xorq	%rdx, %rdx
               	movq	%rdi, %xmm0
               	movq	%rsi, %xmm1
               	movq	%rdx, %xmm2
               	movq	%rdx, %xmm3
               	movq	%rdx, %xmm4
               	movq	%rdx, %xmm5
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	leaq	-0x60(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
