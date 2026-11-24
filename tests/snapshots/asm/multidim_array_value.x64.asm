
multidim_array_value.x64:	file format elf64-x86-64

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

<one>:
               	movl	$0x1, %eax
               	retq

<zwei>:
               	movl	$0x2, %eax
               	retq

<main>:
               	subq	$0x28, %rsp
               	leaq	0x8(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x6, %eax
               	jne	<addr>
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movl	$0x2a, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movl	0x14(%rsp), %eax
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movl	0x1c(%rsp), %eax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x6, %eax
               	jne	<addr>
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	0xc(%rcx), %rax
               	subq	%rcx, %rax
               	movabsq	$0x2aaaaaaaaaaaaaab, %rsi # imm = 0x2AAAAAAAAAAAAAAB
               	imulq	%rsi
               	sarq	%rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	leaq	0x18(%rcx), %rax
               	subq	%rcx, %rax
               	imulq	%rsi
               	sarq	%rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x30(%rcx), %rax
               	subq	%rcx, %rax
               	imulq	%rsi
               	sarq	$0x3, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	0x8(%rsp), %rcx
               	leaq	0xc(%rcx), %rax
               	movl	(%rax), %edx
               	cmpl	$0xa, %edx
               	jne	<addr>
               	subq	%rcx, %rax
               	imulq	%rsi
               	sarq	%rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x2, %rax
               	movl	0x8(%rsp), %ecx
               	addq	%rcx, %rax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0xf, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x9, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x7, %eax
               	addq	$0x28, %rsp
               	retq
