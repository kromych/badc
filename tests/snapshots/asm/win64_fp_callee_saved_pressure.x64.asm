
win64_fp_callee_saved_pressure.x64:	file format elf64-x86-64

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
               	movsd	%xmm0, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	leave
               	retq

<mix3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movsd	%xmm0, 0x28(%rsp)
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	%xmm2, 0x10(%rsp)
               	movsd	%xmm3, 0x18(%rsp)
               	movsd	0x20(%rsp), %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x8(%rsp)
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	movsd	0x10(%rsp), %xmm14
               	vmulsd	%xmm0, %xmm14, %xmm0
               	movsd	0x28(%rsp), %xmm13
               	vfmadd132sd	0x8(%rsp), %xmm0, %xmm13 # xmm13 = (xmm13 * mem) + xmm0
               	movsd	%xmm13, 0x28(%rsp)
               	movsd	0x18(%rsp), %xmm0
               	callq	<addr>
               	movsd	0x28(%rsp), %xmm14
               	vfmadd132sd	0x20(%rsp), %xmm14, %xmm0 # xmm0 = (xmm0 * mem) + xmm14
               	vaddsd	0x18(%rsp), %xmm0, %xmm0
               	leave
               	retq

<pressure>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	%xmm1, -0x8(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	-0x8(%rbp), %xmm1
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	vaddsd	%xmm15, %xmm1, %xmm14
               	movsd	%xmm14, 0x8(%rsp)
               	movsd	-0x10(%rbp), %xmm1
               	movsd	-0x8(%rbp), %xmm2
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm13
               	vfmadd231sd	%xmm2, %xmm1, %xmm13 # xmm13 = (xmm1 * xmm2) + xmm13
               	movsd	%xmm13, 0x20(%rsp)
               	movsd	-0x10(%rbp), %xmm1
               	movsd	-0x8(%rbp), %xmm2
               	subsd	%xmm2, %xmm1
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm15
               	vaddsd	%xmm15, %xmm1, %xmm14
               	movsd	%xmm14, 0x18(%rsp)
               	movsd	-0x10(%rbp), %xmm1
               	movsd	-0x8(%rbp), %xmm2
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movq	%rax, %xmm13
               	vfmadd213sd	%xmm1, %xmm2, %xmm13 # xmm13 = (xmm2 * xmm13) + xmm1
               	movsd	%xmm13, 0x10(%rsp)
               	movsd	-0x10(%rbp), %xmm1
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movsd	-0x8(%rbp), %xmm2
               	movq	%rax, %xmm13
               	vfmadd213sd	%xmm2, %xmm1, %xmm13 # xmm13 = (xmm1 * xmm13) + xmm2
               	movsd	%xmm13, 0x58(%rsp)
               	movsd	-0x10(%rbp), %xmm1
               	movabsq	$0x401c000000000000, %rax # imm = 0x401C000000000000
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm1
               	movsd	-0x8(%rbp), %xmm2
               	vaddsd	%xmm2, %xmm1, %xmm14
               	movsd	%xmm14, 0x50(%rsp)
               	movsd	-0x10(%rbp), %xmm1
               	movsd	-0x8(%rbp), %xmm2
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm2
               	vaddsd	%xmm2, %xmm1, %xmm14
               	movsd	%xmm14, 0x48(%rsp)
               	movsd	-0x10(%rbp), %xmm1
               	movsd	-0x8(%rbp), %xmm2
               	movabsq	$0x4022000000000000, %rax # imm = 0x4022000000000000
               	movq	%rax, %xmm13
               	vfmadd231sd	%xmm2, %xmm1, %xmm13 # xmm13 = (xmm1 * xmm2) + xmm13
               	movsd	%xmm13, 0x40(%rsp)
               	movsd	-0x10(%rbp), %xmm1
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	movsd	-0x8(%rbp), %xmm2
               	movq	%rax, %xmm13
               	vfmadd213sd	%xmm2, %xmm1, %xmm13 # xmm13 = (xmm1 * xmm13) + xmm2
               	movsd	%xmm13, 0x38(%rsp)
               	movsd	-0x10(%rbp), %xmm1
               	movsd	-0x8(%rbp), %xmm2
               	movabsq	$0x4026000000000000, %rax # imm = 0x4026000000000000
               	movq	%rax, %xmm13
               	vfmadd213sd	%xmm1, %xmm2, %xmm13 # xmm13 = (xmm2 * xmm13) + xmm1
               	movsd	%xmm13, 0x30(%rsp)
               	movsd	0x8(%rsp), %xmm1
               	movsd	0x20(%rsp), %xmm2
               	movsd	0x30(%rsp), %xmm3
               	callq	<addr>
               	movsd	%xmm0, 0x28(%rsp)
               	movsd	0x8(%rsp), %xmm0
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x18(%rsp), %xmm2
               	movsd	0x38(%rsp), %xmm3
               	callq	<addr>
               	movsd	%xmm0, 0x8(%rsp)
               	movsd	0x20(%rsp), %xmm0
               	movsd	0x18(%rsp), %xmm1
               	movsd	0x10(%rsp), %xmm2
               	movsd	0x40(%rsp), %xmm3
               	callq	<addr>
               	movsd	%xmm0, 0x20(%rsp)
               	movsd	0x18(%rsp), %xmm0
               	movsd	0x10(%rsp), %xmm1
               	movsd	0x58(%rsp), %xmm2
               	movsd	0x48(%rsp), %xmm3
               	callq	<addr>
               	movsd	%xmm0, 0x18(%rsp)
               	movsd	0x10(%rsp), %xmm0
               	movsd	0x58(%rsp), %xmm1
               	movsd	0x50(%rsp), %xmm2
               	movsd	0x50(%rsp), %xmm3
               	callq	<addr>
               	movsd	%xmm0, 0x10(%rsp)
               	movsd	0x58(%rsp), %xmm0
               	movsd	0x50(%rsp), %xmm1
               	movsd	0x48(%rsp), %xmm2
               	movsd	0x58(%rsp), %xmm3
               	callq	<addr>
               	movsd	%xmm0, 0x58(%rsp)
               	movsd	0x50(%rsp), %xmm0
               	movsd	0x48(%rsp), %xmm1
               	movsd	0x40(%rsp), %xmm2
               	movsd	0x10(%rsp), %xmm3
               	callq	<addr>
               	movsd	%xmm0, 0x50(%rsp)
               	movsd	0x48(%rsp), %xmm0
               	movsd	0x40(%rsp), %xmm1
               	movsd	0x38(%rsp), %xmm2
               	movsd	0x18(%rsp), %xmm3
               	callq	<addr>
               	movsd	%xmm0, 0x48(%rsp)
               	movsd	0x40(%rsp), %xmm0
               	movsd	0x38(%rsp), %xmm1
               	movsd	0x30(%rsp), %xmm2
               	movsd	0x20(%rsp), %xmm3
               	callq	<addr>
               	movsd	%xmm0, 0x40(%rsp)
               	movsd	0x38(%rsp), %xmm0
               	movsd	0x30(%rsp), %xmm1
               	movsd	0x28(%rsp), %xmm2
               	movsd	0x8(%rsp), %xmm3
               	callq	<addr>
               	movsd	%xmm0, 0x38(%rsp)
               	movsd	0x30(%rsp), %xmm0
               	movsd	0x28(%rsp), %xmm1
               	movsd	0x8(%rsp), %xmm2
               	movsd	0x28(%rsp), %xmm3
               	callq	<addr>
               	movsd	0x28(%rsp), %xmm14
               	vaddsd	0x8(%rsp), %xmm14, %xmm1
               	vaddsd	0x20(%rsp), %xmm1, %xmm1
               	vaddsd	0x18(%rsp), %xmm1, %xmm1
               	vaddsd	0x10(%rsp), %xmm1, %xmm1
               	vaddsd	0x58(%rsp), %xmm1, %xmm1
               	vaddsd	0x50(%rsp), %xmm1, %xmm1
               	vaddsd	0x48(%rsp), %xmm1, %xmm1
               	vaddsd	0x40(%rsp), %xmm1, %xmm1
               	vaddsd	0x38(%rsp), %xmm1, %xmm1
               	vaddsd	%xmm0, %xmm1, %xmm0
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	callq	<addr>
               	movsd	%xmm0, 0x8(%rsp)
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	callq	<addr>
               	movsd	0x8(%rsp), %xmm14
               	ucomisd	%xmm0, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movsd	0x8(%rsp), %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm14, %xmm15
               	jb	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leave
               	retq
