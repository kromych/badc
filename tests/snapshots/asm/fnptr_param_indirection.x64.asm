
fnptr_param_indirection.x64:	file format elf64-x86-64

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

<inc>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<dbl>:
               	movq	%rdi, %rax
               	shlq	%rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-<rip>, %rbx       # <addr>
               	movq	%rbx, (%rax)
               	movq	-0x8(%rbp), %rax
               	leaq	-<rip>, %rcx       # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0xa, %edi
               	movq	-0x8(%rbp), %rax
               	callq	*%rax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-<rip>, %rcx       # <addr>
               	movq	%rcx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0xa, %edi
               	callq	*%rax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rbx, (%rax)
               	movq	-0x8(%rbp), %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	movl	$0x3, %edi
               	movq	-0x8(%rbp), %rax
               	callq	*%rax
               	cmpl	$0x4, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
