
win64_xmm_callee_save_paths.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x38, %rsp
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x28(%rsp)
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x20(%rsp)
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x18(%rsp)
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x10(%rsp)
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x8(%rsp)
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm14
               	vmulsd	0x10(%rsp), %xmm14, %xmm1
               	movsd	0x28(%rsp), %xmm14
               	vfmadd231sd	0x20(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	vfmadd231sd	0x8(%rsp), %xmm0, %xmm1 # xmm1 = (xmm0 * mem) + xmm1
               	cvttsd2si	%xmm1, %rax
               	movsd	0x28(%rsp), %xmm14
               	vfmadd132sd	<rip>, %xmm14, %xmm1 # xmm1 = (xmm1 * mem) + xmm14
               	cvttsd2si	%xmm1, %rcx
               	cmpl	$0x2c, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	cmpl	$0x59, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x38, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x28(%rsp)
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x20(%rsp)
               	xorps	%xmm0, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x18(%rsp)
               	xorps	%xmm0, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x10(%rsp)
               	xorps	%xmm0, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x8(%rsp)
               	xorps	%xmm0, %xmm0
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm14
               	vmulsd	0x10(%rsp), %xmm14, %xmm1
               	movsd	0x28(%rsp), %xmm14
               	vfmadd231sd	0x20(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	vfmadd231sd	0x8(%rsp), %xmm0, %xmm1 # xmm1 = (xmm0 * mem) + xmm1
               	cvttsd2si	%xmm1, %rax
               	movsd	0x28(%rsp), %xmm14
               	vfmadd132sd	<rip>, %xmm14, %xmm1 # xmm1 = (xmm1 * mem) + xmm14
               	cvttsd2si	%xmm1, %rcx
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x38, %rsp
               	retq
               	cmpl	$0x1e, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq
