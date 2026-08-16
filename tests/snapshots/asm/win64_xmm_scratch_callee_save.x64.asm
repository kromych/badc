
win64_xmm_scratch_callee_save.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<rt>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movsd	%xmm0, -0x8(%rbp,%riz)
               	movsd	-0x8(%rbp,%riz), %xmm0
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movabsq	$0x3ff0000000000000, %rdi # imm = 0x3FF0000000000000
               	movq	%rdi, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x38(%rsp)
               	movabsq	$0x4000000000000000, %rdi # imm = 0x4000000000000000
               	movq	%rdi, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x30(%rsp)
               	movabsq	$0x4008000000000000, %rdi # imm = 0x4008000000000000
               	movq	%rdi, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x20(%rsp)
               	movabsq	$0x4010000000000000, %rdi # imm = 0x4010000000000000
               	movq	%rdi, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x18(%rsp)
               	movabsq	$0x4014000000000000, %rdi # imm = 0x4014000000000000
               	movq	%rdi, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x28(%rsp)
               	movabsq	$0x4018000000000000, %rdi # imm = 0x4018000000000000
               	movq	%rdi, %xmm0
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm15
               	movsd	0x20(%rsp), %xmm1
               	mulsd	%xmm15, %xmm1
               	movsd	0x38(%rsp), %xmm14
               	movsd	0x30(%rsp), %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movsd	0x28(%rsp), %xmm14
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	cvttsd2si	%xmm0, %rcx
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movsd	0x38(%rsp), %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	cvttsd2si	%xmm0, %rax
               	movslq	%ecx, %rcx
               	cmpq	$0x2c, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	%eax, %rax
               	cmpq	$0x59, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4024000000000000, %rdi # imm = 0x4024000000000000
               	movq	%rdi, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x38(%rsp)
               	movabsq	$0x3ff0000000000000, %rdi # imm = 0x3FF0000000000000
               	movq	%rdi, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x30(%rsp)
               	xorq	%rbx, %rbx
               	movq	%rbx, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x20(%rsp)
               	movq	%rbx, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x18(%rsp)
               	movq	%rbx, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%rbx, %xmm0
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm15
               	movsd	0x20(%rsp), %xmm1
               	mulsd	%xmm15, %xmm1
               	movsd	0x38(%rsp), %xmm14
               	movsd	0x30(%rsp), %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movsd	0x28(%rsp), %xmm14
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	cvttsd2si	%xmm0, %rcx
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movsd	0x38(%rsp), %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	cvttsd2si	%xmm0, %rax
               	movslq	%ecx, %rcx
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	%eax, %rax
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
