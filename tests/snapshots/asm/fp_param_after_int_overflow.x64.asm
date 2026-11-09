
fp_param_after_int_overflow.x64:	file format elf64-x86-64

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

<tail_double>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movl	0x10(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	0x18(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	0x20(%rbp), %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	vaddsd	%xmm0, %xmm1, %xmm0
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	subq	$0x20, %rsp
               	movl	$0x7, %r10d
               	movq	%r10, (%rsp)
               	movl	$0x8, %r10d
               	movq	%r10, 0x8(%rsp)
               	movl	$0x9, %r10d
               	movq	%r10, 0x10(%rsp)
               	movq	%rax, %xmm0
               	callq	<addr>
               	addq	$0x20, %rsp
               	movabsq	$0x4046c00000000000, %rax # imm = 0x4046C00000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	movl	$0x14, %esi
               	movl	$0x1e, %edx
               	movl	$0x28, %ecx
               	movl	$0x32, %r8d
               	movl	$0x3c, %r9d
               	movabsq	$0x3fd0000000000000, %rax # imm = 0x3FD0000000000000
               	subq	$0x20, %rsp
               	movl	$0x46, %r10d
               	movq	%r10, (%rsp)
               	movl	$0x50, %r10d
               	movq	%r10, 0x8(%rsp)
               	movl	$0x5a, %r10d
               	movq	%r10, 0x10(%rsp)
               	movq	%rax, %xmm0
               	callq	<addr>
               	addq	$0x20, %rsp
               	movabsq	$0x407c240000000000, %rax # imm = 0x407C240000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
