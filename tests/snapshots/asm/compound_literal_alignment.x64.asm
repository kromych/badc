
compound_literal_alignment.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	andq	$0xf, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	andq	$0xf, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rdx
               	andq	$0xf, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdi
               	andq	$0xf, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	(%rax), %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x1, %rdi
               	jne	<addr>
               	movq	(%rax), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	(%rcx), %rax
               	movq	(%rax), %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	(%rsi), %rax
               	movq	(%rax), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movq	(%rdx), %rax
               	movq	(%rax), %rax
               	cmpq	$0x6, %rax
               	jne	<addr>
               	movq	(%rdx), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0xb, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0xd, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	andq	$0xf, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
