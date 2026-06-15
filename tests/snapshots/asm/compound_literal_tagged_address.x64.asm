
compound_literal_tagged_address.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	leaq	<rip>, %rax
               	movq	%rax, %rcx
               	orq	$0x1, %rcx
               	leaq	-0x10(%rbp), %rdx
               	movq	%rcx, (%rdx)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x8(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %rcx
               	andq	$-0x2, %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	popq	%rax
               	movq	%rax, %rcx
               	shrq	$0x2, %rcx
               	leaq	-0x20(%rbp), %rdx
               	movq	%rcx, (%rdx)
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x18(%rbp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	-0x18(%rbp), %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x40(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rcx
               	addq	$0x8, %rcx
               	leaq	-0x40(%rbp), %rdx
               	movq	%rcx, 0x8(%rdx)
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x30(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x30(%rbp), %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
