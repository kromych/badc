
typeof_abstract_array_type.x64:	file format elf64-x86-64

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
               	subq	$0x90, %rsp
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rdx
               	imulq	$0xc, %rax, %rsi
               	addq	%rsi, %rdx
               	leaq	(%rdx), %rsi
               	imulq	$0xa, %rax, %rdx
               	addq	$0x0, %rdx
               	movl	%edx, (%rsi)
               	leaq	-0x40(%rbp), %rdx
               	imulq	$0xc, %rax, %rsi
               	addq	%rdx, %rsi
               	imulq	$0xa, %rax, %rdx
               	incq	%rdx
               	movl	%edx, 0x4(%rsi)
               	leaq	-0x40(%rbp), %rdx
               	imulq	$0xc, %rax, %rsi
               	addq	%rdx, %rsi
               	imulq	$0xa, %rax, %rdx
               	addq	$0x2, %rdx
               	movl	%edx, 0x8(%rsi)
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x2, %rax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	movslq	0x14(%rax), %rax
               	cmpq	$0xc, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x9, %ecx
               	movq	%rcx, 0x10(%rax)
               	cmpq	$0x9, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
