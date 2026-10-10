
multidim_array_value.x64:	file format elf64-x86-64

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

<one>:
               	movl	$0x1, %eax
               	retq

<zwei>:
               	movl	$0x2, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	<rip>, %rax      # <addr>
               	leaq	0xc(%rax), %rcx
               	movl	0x8(%rcx), %edx
               	cmpl	$0x6, %edx
               	jne	<addr>
               	movl	0x8(%rcx), %edx
               	cmpl	$0x6, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx      # <addr>
               	movl	$0x2a, 0x5c(%rdx)
               	movl	0x5c(%rdx), %edx
               	cmpl	$0x2a, %edx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	0xc(%rax), %edx
               	cmpl	$0x4, %edx
               	jne	<addr>
               	movl	-0xc(%rbp), %edx
               	cmpl	$0xa, %edx
               	jne	<addr>
               	movl	-0x4(%rbp), %edx
               	cmpl	$0xc, %edx
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movl	0x4(%rcx), %ecx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movl	0x14(%rcx), %eax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movl	0x14(%rcx), %eax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movl	0x10(%rcx), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	0xc(%rcx), %rax
               	subq	%rcx, %rax
               	movabsq	$0x2aaaaaaaaaaaaaab, %rsi # imm = 0x2AAAAAAAAAAAAAAB
               	imulq	%rsi
               	movq	%rdx, %rax
               	sarq	%rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	leaq	0x18(%rcx), %rax
               	subq	%rcx, %rax
               	imulq	%rsi
               	movq	%rdx, %rax
               	sarq	%rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	leaq	<rip>, %rcx      # <addr>
               	leaq	0x30(%rcx), %rax
               	subq	%rcx, %rax
               	imulq	%rsi
               	movq	%rdx, %rax
               	sarq	$0x3, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rdx
               	leaq	0xc(%rdx), %rcx
               	movl	(%rcx), %eax
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	imulq	%rsi
               	movq	%rdx, %rax
               	sarq	%rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	cmpq	%rcx, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	0x10(%rax), %rax
               	callq	*%rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	0x8(%rax), %rax
               	callq	*%rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	addq	$0x10, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	addq	$0x10, %rax
               	movq	0x8(%rax), %rax
               	callq	*%rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	0x14(%rax), %eax
               	addq	$0x2, %rax
               	movl	-0x18(%rbp), %ecx
               	addq	%rcx, %rax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x7, %eax
               	leave
               	retq
