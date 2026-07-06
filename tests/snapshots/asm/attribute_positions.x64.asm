
attribute_positions.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<inl>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<use>:
               	movq	%rsi, %rax
               	movslq	%eax, %rax
               	retq

<probe>:
               	movl	$0x3, %eax
               	retq

<make>:
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0xb, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x16, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0xb, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x16, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
