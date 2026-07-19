
ptr_to_array_typedef.x64:	file format elf64-x86-64

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
               	subq	$0xb0, %rsp
               	xorq	%rcx, %rcx
               	movq	%rcx, -0x28(%rbp)
               	jmp	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x5, %rsi
               	addq	%rsi, %rdx
               	leaq	(%rdx), %rsi
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	$0x0, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, (%rsi)
               	leaq	-0x88(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x5, %rsi
               	addq	%rdx, %rsi
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	incq	%rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x8(%rsi)
               	leaq	-0x88(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x5, %rsi
               	addq	%rdx, %rsi
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	$0x2, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x10(%rsi)
               	leaq	-0x88(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x5, %rsi
               	addq	%rdx, %rsi
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	$0x3, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x18(%rsi)
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jl	<addr>
               	leaq	-0x28(%rbp), %rcx
               	leaq	<rip>, %rax
               	movl	$0x2, %edx
               	movq	%rdx, 0x18(%rax)
               	movq	%rax, (%rcx)
               	movq	-0x28(%rbp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movq	-0x28(%rbp), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x28(%rbp), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movq	-0x28(%rbp), %rax
               	movq	0x18(%rax), %rax
               	leaq	0x1e(%rax), %rcx
               	leaq	-0x88(%rbp), %rax
               	movq	0x30(%rax), %rdx
               	movq	0x58(%rax), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	subq	$0x7, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
