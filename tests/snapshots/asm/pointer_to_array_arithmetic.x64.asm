
pointer_to_array_arithmetic.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	leaq	0x10(%rax), %rcx
               	movq	%rcx, %rdi
               	subq	%rax, %rdi
               	cmpq	$0x10, %rdi
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	0x8(%rax), %rdx
               	movq	%rdx, %rsi
               	subq	%rax, %rsi
               	cmpq	$0x8, %rsi
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpq	$0x10, %rdi
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movslq	(%rcx), %rdi
               	cmpl	$0x4, %edi
               	jne	<addr>
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0x5, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	%rsi, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rsi, %rcx
               	sarq	$0x3, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movslq	0x4(%rax), %rcx
               	movslq	0x4(%rdx), %rdx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	cmpl	$0x3, %edx
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
