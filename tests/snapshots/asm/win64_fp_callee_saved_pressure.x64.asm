
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
               	movsd	<rip>, %xmm1
               	vaddsd	%xmm1, %xmm0, %xmm1
               	movsd	-0x8(%rbp), %xmm0
               	movsd	<rip>, %xmm2
               	addsd	%xmm2, %xmm0
               	movsd	-0x10(%rbp), %xmm2
               	movsd	-0x8(%rbp), %xmm3
               	movsd	<rip>, %xmm4
               	movapd	%xmm2, %xmm13
               	vfmadd213sd	%xmm4, %xmm3, %xmm13 # xmm13 = (xmm3 * xmm13) + xmm4
               	movsd	%xmm13, 0x20(%rsp)
               	movsd	-0x10(%rbp), %xmm2
               	movsd	-0x8(%rbp), %xmm3
               	subsd	%xmm3, %xmm2
               	movsd	<rip>, %xmm3
               	vaddsd	%xmm3, %xmm2, %xmm14
               	movsd	%xmm14, 0x18(%rsp)
               	movsd	-0x10(%rbp), %xmm2
               	movsd	-0x8(%rbp), %xmm3
               	movsd	<rip>, %xmm4
               	movapd	%xmm3, %xmm13
               	vfmadd213sd	%xmm2, %xmm4, %xmm13 # xmm13 = (xmm4 * xmm13) + xmm2
               	movsd	%xmm13, 0x10(%rsp)
               	movsd	-0x10(%rbp), %xmm2
               	movsd	<rip>, %xmm3
               	movsd	-0x8(%rbp), %xmm4
               	movapd	%xmm2, %xmm13
               	vfmadd213sd	%xmm4, %xmm3, %xmm13 # xmm13 = (xmm3 * xmm13) + xmm4
               	movsd	%xmm13, 0x58(%rsp)
               	movsd	-0x10(%rbp), %xmm2
               	movsd	<rip>, %xmm3
               	divsd	%xmm3, %xmm2
               	movsd	-0x8(%rbp), %xmm3
               	vaddsd	%xmm3, %xmm2, %xmm14
               	movsd	%xmm14, 0x50(%rsp)
               	movsd	-0x10(%rbp), %xmm2
               	movsd	-0x8(%rbp), %xmm3
               	movsd	<rip>, %xmm4
               	divsd	%xmm4, %xmm3
               	vaddsd	%xmm3, %xmm2, %xmm14
               	movsd	%xmm14, 0x48(%rsp)
               	movsd	-0x10(%rbp), %xmm2
               	movsd	-0x8(%rbp), %xmm3
               	movsd	<rip>, %xmm4
               	movapd	%xmm2, %xmm13
               	vfmadd213sd	%xmm4, %xmm3, %xmm13 # xmm13 = (xmm3 * xmm13) + xmm4
               	movsd	%xmm13, 0x40(%rsp)
               	movsd	-0x10(%rbp), %xmm2
               	movsd	<rip>, %xmm3
               	movsd	-0x8(%rbp), %xmm4
               	movapd	%xmm2, %xmm13
               	vfmadd213sd	%xmm4, %xmm3, %xmm13 # xmm13 = (xmm3 * xmm13) + xmm4
               	movsd	%xmm13, 0x38(%rsp)
               	movsd	-0x10(%rbp), %xmm2
               	movsd	-0x8(%rbp), %xmm3
               	movsd	<rip>, %xmm4
               	movapd	%xmm3, %xmm13
               	vfmadd213sd	%xmm2, %xmm4, %xmm13 # xmm13 = (xmm4 * xmm13) + xmm2
               	movsd	%xmm13, 0x30(%rsp)
               	movsd	%xmm0, (%rsp)
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	movsd	0x20(%rsp), %xmm2
               	movsd	0x30(%rsp), %xmm3
               	callq	<addr>
               	movsd	%xmm0, 0x28(%rsp)
               	movsd	(%rsp), %xmm0
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
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	callq	<addr>
               	movapd	%xmm0, %xmm1
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm2
               	movsd	%xmm1, 0x8(%rsp)
               	movapd	%xmm2, %xmm1
               	callq	<addr>
               	movsd	0x8(%rsp), %xmm1
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	comisd	%xmm1, %xmm15
               	jb	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leave
               	retq
