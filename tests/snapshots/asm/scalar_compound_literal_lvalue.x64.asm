
scalar_compound_literal_lvalue.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x5, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	cmpl	$0x5, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0xa, (%rcx)
               	movl	$0x9, -0x8(%rbp)
               	movslq	(%rcx), %rdx
               	cmpl	$0x9, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movabsq	$0x4004000000000000, %rdx # imm = 0x4004000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movsd	(%rcx), %xmm0
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movb	$0x41, -0x8(%rbp)
               	movsbq	(%rcx), %rdx
               	cmpl	$0x41, %edx
               	je	<addr>
               	leave
               	retq
               	movl	$0x7, %eax
               	movl	%eax, -0x8(%rbp)
               	movslq	(%rcx), %rdx
               	cmpl	$0x7, %edx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x2a, -0x8(%rbp)
               	movslq	(%rcx), %rcx
               	cmpl	$0x2a, %ecx
               	je	<addr>
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rax)
               	xorl	%eax, %eax
               	leave
               	retq
