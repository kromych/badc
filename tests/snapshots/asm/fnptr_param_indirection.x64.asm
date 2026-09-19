
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
               	subq	$0x10, %rsp
               	movq	$0x0, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, (%rcx)
               	movq	-0x8(%rbp), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movl	$0xa, %edi
               	movq	-0x8(%rbp), %rax
               	callq	*%rax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movl	$0xa, %edi
               	movq	%rcx, %rax
               	callq	*%rax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movq	$0x0, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, (%rcx)
               	movq	-0x8(%rbp), %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movl	$0x3, %edi
               	movq	-0x8(%rbp), %rax
               	callq	*%rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
