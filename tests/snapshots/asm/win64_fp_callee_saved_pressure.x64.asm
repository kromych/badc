
win64_fp_callee_saved_pressure.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x18, %rsp
               	movsd	%xmm0, 0x8(%rsp)
               	movsd	0x8(%rsp), %xmm0
               	addq	$0x18, %rsp
               	retq

<mix3>:
               	subq	$0x38, %rsp
               	movsd	%xmm0, 0x28(%rsp)
               	movsd	%xmm2, 0x18(%rsp)
               	movsd	%xmm3, 0x20(%rsp)
               	movsd	%xmm1, 0x10(%rsp)
               	movapd	%xmm1, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x8(%rsp)
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm14
               	vmulsd	%xmm0, %xmm14, %xmm0
               	movsd	0x28(%rsp), %xmm15
               	vfmadd132sd	0x8(%rsp), %xmm0, %xmm15 # xmm15 = (xmm15 * mem) + xmm0
               	movsd	%xmm15, 0x28(%rsp)
               	movsd	0x20(%rsp), %xmm0
               	callq	<addr>
               	movsd	0x28(%rsp), %xmm14
               	vfmadd132sd	0x10(%rsp), %xmm14, %xmm0 # xmm0 = (xmm0 * mem) + xmm14
               	vaddsd	0x20(%rsp), %xmm0, %xmm0
               	addq	$0x38, %rsp
               	retq

<pressure>:
               	subq	$0x78, %rsp
               	movsd	%xmm0, 0x60(%rsp)
               	movsd	%xmm1, 0x68(%rsp)
               	movsd	0x60(%rsp), %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	movsd	0x68(%rsp), %xmm1
               	vaddsd	<rip>, %xmm1, %xmm1
               	movsd	0x60(%rsp), %xmm2
               	movsd	0x68(%rsp), %xmm3
               	movapd	%xmm2, %xmm15
               	vfmadd213sd	<rip>, %xmm3, %xmm15 # xmm15 = (xmm3 * xmm15) + mem
               	movsd	%xmm15, 0x28(%rsp)
               	movsd	0x60(%rsp), %xmm2
               	movsd	0x68(%rsp), %xmm3
               	subsd	%xmm3, %xmm2
               	vaddsd	<rip>, %xmm2, %xmm14
               	movsd	%xmm14, 0x20(%rsp)
               	movsd	0x60(%rsp), %xmm2
               	movsd	0x68(%rsp), %xmm3
               	movapd	%xmm3, %xmm15
               	vfmadd132sd	<rip>, %xmm2, %xmm15 # xmm15 = (xmm15 * mem) + xmm2
               	movsd	%xmm15, 0x18(%rsp)
               	movsd	0x60(%rsp), %xmm2
               	movsd	0x68(%rsp), %xmm3
               	movapd	%xmm2, %xmm15
               	vfmadd132sd	<rip>, %xmm3, %xmm15 # xmm15 = (xmm15 * mem) + xmm3
               	movsd	%xmm15, 0x58(%rsp)
               	movsd	0x60(%rsp), %xmm2
               	vdivsd	<rip>, %xmm2, %xmm2
               	movsd	0x68(%rsp), %xmm3
               	vaddsd	%xmm3, %xmm2, %xmm14
               	movsd	%xmm14, 0x50(%rsp)
               	movsd	0x60(%rsp), %xmm2
               	movsd	0x68(%rsp), %xmm3
               	vdivsd	<rip>, %xmm3, %xmm3
               	vaddsd	%xmm3, %xmm2, %xmm14
               	movsd	%xmm14, 0x48(%rsp)
               	movsd	0x60(%rsp), %xmm2
               	movsd	0x68(%rsp), %xmm3
               	movapd	%xmm2, %xmm15
               	vfmadd213sd	<rip>, %xmm3, %xmm15 # xmm15 = (xmm3 * xmm15) + mem
               	movsd	%xmm15, 0x40(%rsp)
               	movsd	0x60(%rsp), %xmm2
               	movsd	0x68(%rsp), %xmm3
               	movapd	%xmm2, %xmm15
               	vfmadd132sd	<rip>, %xmm3, %xmm15 # xmm15 = (xmm15 * mem) + xmm3
               	movsd	%xmm15, 0x38(%rsp)
               	movsd	0x60(%rsp), %xmm3
               	movsd	0x68(%rsp), %xmm2
               	vfmadd231sd	<rip>, %xmm2, %xmm3 # xmm3 = (xmm2 * mem) + xmm3
               	movsd	%xmm3, 0x10(%rsp)
               	movsd	%xmm1, (%rsp)
               	movsd	0x28(%rsp), %xmm2
               	callq	<addr>
               	movsd	%xmm0, 0x30(%rsp)
               	movsd	(%rsp), %xmm1
               	movapd	%xmm1, %xmm0
               	movsd	0x28(%rsp), %xmm1
               	movsd	0x20(%rsp), %xmm2
               	movsd	0x38(%rsp), %xmm3
               	callq	<addr>
               	movsd	%xmm0, 0x8(%rsp)
               	movsd	0x28(%rsp), %xmm0
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x18(%rsp), %xmm2
               	movsd	0x40(%rsp), %xmm3
               	callq	<addr>
               	movsd	%xmm0, 0x28(%rsp)
               	movsd	0x20(%rsp), %xmm0
               	movsd	0x18(%rsp), %xmm1
               	movsd	0x58(%rsp), %xmm2
               	movsd	0x48(%rsp), %xmm3
               	callq	<addr>
               	movsd	%xmm0, 0x20(%rsp)
               	movsd	0x18(%rsp), %xmm0
               	movsd	0x58(%rsp), %xmm1
               	movsd	0x50(%rsp), %xmm2
               	movsd	0x50(%rsp), %xmm3
               	callq	<addr>
               	movsd	%xmm0, 0x18(%rsp)
               	movsd	0x58(%rsp), %xmm0
               	movsd	0x50(%rsp), %xmm1
               	movsd	0x48(%rsp), %xmm2
               	movsd	0x58(%rsp), %xmm3
               	callq	<addr>
               	movsd	%xmm0, 0x58(%rsp)
               	movsd	0x50(%rsp), %xmm0
               	movsd	0x48(%rsp), %xmm1
               	movsd	0x40(%rsp), %xmm2
               	movsd	0x18(%rsp), %xmm3
               	callq	<addr>
               	movsd	%xmm0, 0x50(%rsp)
               	movsd	0x48(%rsp), %xmm0
               	movsd	0x40(%rsp), %xmm1
               	movsd	0x38(%rsp), %xmm2
               	movsd	0x20(%rsp), %xmm3
               	callq	<addr>
               	movsd	%xmm0, 0x48(%rsp)
               	movsd	0x40(%rsp), %xmm0
               	movsd	0x38(%rsp), %xmm1
               	movsd	0x10(%rsp), %xmm2
               	movsd	0x28(%rsp), %xmm3
               	callq	<addr>
               	movsd	%xmm0, 0x40(%rsp)
               	movsd	0x38(%rsp), %xmm0
               	movsd	0x10(%rsp), %xmm1
               	movsd	0x30(%rsp), %xmm2
               	movsd	0x8(%rsp), %xmm3
               	callq	<addr>
               	movsd	%xmm0, 0x38(%rsp)
               	movsd	0x10(%rsp), %xmm0
               	movsd	0x30(%rsp), %xmm1
               	movsd	0x8(%rsp), %xmm2
               	movsd	0x30(%rsp), %xmm3
               	callq	<addr>
               	movsd	0x30(%rsp), %xmm14
               	vaddsd	0x8(%rsp), %xmm14, %xmm1
               	vaddsd	0x28(%rsp), %xmm1, %xmm1
               	vaddsd	0x20(%rsp), %xmm1, %xmm1
               	vaddsd	0x18(%rsp), %xmm1, %xmm1
               	vaddsd	0x58(%rsp), %xmm1, %xmm1
               	vaddsd	0x50(%rsp), %xmm1, %xmm1
               	vaddsd	0x48(%rsp), %xmm1, %xmm1
               	vaddsd	0x40(%rsp), %xmm1, %xmm1
               	vaddsd	0x38(%rsp), %xmm1, %xmm1
               	vaddsd	%xmm0, %xmm1, %xmm0
               	addq	$0x78, %rsp
               	retq

<main>:
               	subq	$0x18, %rsp
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	callq	<addr>
               	movapd	%xmm0, %xmm2
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	movsd	%xmm2, 0x8(%rsp)
               	callq	<addr>
               	movsd	0x8(%rsp), %xmm2
               	ucomisd	%xmm0, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	comisd	%xmm2, %xmm14
               	jb	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	addq	$0x18, %rsp
               	retq
