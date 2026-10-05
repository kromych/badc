
win64_xmm_callee_save_paths.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x28(%rsp)
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x20(%rsp)
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x18(%rsp)
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x10(%rsp)
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x8(%rsp)
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm14
               	vmulsd	0x10(%rsp), %xmm14, %xmm1
               	movsd	0x28(%rsp), %xmm14
               	vfmadd231sd	0x20(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	vfmadd132sd	0x8(%rsp), %xmm1, %xmm0 # xmm0 = (xmm0 * mem) + xmm1
               	cvttsd2si	%xmm0, %rax
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movsd	0x28(%rsp), %xmm14
               	movq	%rcx, %xmm15
               	vfmadd132sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm0 * xmm15) + xmm14
               	cvttsd2si	%xmm0, %rcx
               	cmpl	$0x2c, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	cmpl	$0x59, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x28(%rsp)
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x20(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x18(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x10(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x8(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %xmm0
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm14
               	vmulsd	0x10(%rsp), %xmm14, %xmm1
               	movsd	0x28(%rsp), %xmm14
               	vfmadd231sd	0x20(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	vfmadd132sd	0x8(%rsp), %xmm1, %xmm0 # xmm0 = (xmm0 * mem) + xmm1
               	cvttsd2si	%xmm0, %rax
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movsd	0x28(%rsp), %xmm14
               	movq	%rcx, %xmm15
               	vfmadd132sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm0 * xmm15) + xmm14
               	cvttsd2si	%xmm0, %rcx
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	cmpl	$0x1e, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
