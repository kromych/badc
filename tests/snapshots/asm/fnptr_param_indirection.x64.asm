
fnptr_param_indirection.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<inc>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<dbl>:
               	movq	%rdi, %rax
               	shlq	$0x1, %rax
               	movslq	%eax, %rax
               	retq

<store_through>:
               	movq	%rsi, (%rdi)
               	xorq	%rax, %rax
               	retq

<load_through>:
               	movq	(%rdi), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	leaq	-<rip>, %rbx       # <addr>
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	-0x8(%rbp), %rax
               	leaq	-<rip>, %rcx       # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	movq	-0x8(%rbp), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	movq	%rcx, %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	%rbx, (%rax)
               	movq	-0x20(%rbp), %rax
               	cmpq	%rbx, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x3, %edi
               	movq	-0x20(%rbp), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
