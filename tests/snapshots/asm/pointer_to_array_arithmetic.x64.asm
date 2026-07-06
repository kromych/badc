
pointer_to_array_arithmetic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rax
               	leaq	0x10(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x10, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	0x8(%rax), %rsi
               	movq	%rsi, %rcx
               	subq	%rax, %rcx
               	cmpq	$0x8, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	0x10(%rax), %rcx
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	cmpq	$0x10, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movslq	(%rcx), %rdx
               	cmpq	$0x4, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	0x4(%rcx), %rcx
               	cmpq	$0x5, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	%rsi, %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	shrq	$0x3d, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	0x8(%rax), %rcx
               	movslq	0x4(%rax), %rdx
               	movslq	0x4(%rcx), %rsi
               	cmpq	$0x1, %rdx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpq	$0x3, %rsi
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	0x20(%rax), %rcx
               	addq	$-0x8, %rcx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpq	$0x18, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
