
ptr_diff_plus_ptr.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	popq	%rdx
               	leaq	-0x30(%rbp), %rcx
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x30(%rbp), %rdx
               	addq	$0x20, %rdx
               	movq	%rdx, %rsi
               	subq	%rcx, %rsi
               	movq	%rsi, %rdi
               	sarq	$0x3f, %rdi
               	shrq	$0x3c, %rdi
               	addq	%rdi, %rsi
               	sarq	$0x4, %rsi
               	shlq	$0x4, %rsi
               	addq	%rax, %rsi
               	leaq	-0x30(%rbp), %rdi
               	addq	$0x20, %rdi
               	cmpq	%rdi, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	shrq	$0x3c, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x4, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x10(%rax), %rdx
               	addq	%rdx, %rcx
               	leaq	-0x30(%rbp), %rdx
               	addq	$0x30, %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addq	$0x20, %rax
               	leaq	-0x30(%rbp), %rcx
               	addq	$0x20, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
