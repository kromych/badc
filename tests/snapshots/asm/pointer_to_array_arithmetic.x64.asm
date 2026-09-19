
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
               	movq	%rcx, %rsi
               	subq	%rax, %rsi
               	cmpq	$0x10, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	0x8(%rax), %rdx
               	subq	%rax, %rdx
               	cmpq	$0x8, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpq	$0x10, %rsi
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movslq	(%rcx), %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movslq	0x4(%rcx), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	%rdx, %rax
               	sarq	$0x3f, %rax
               	shrq	$0x3d, %rax
               	addq	%rdx, %rax
               	sarq	$0x3, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	0x8(%rax), %rcx
               	movslq	0x4(%rax), %rdx
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0x1, %edx
               	jne	<addr>
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	0x20(%rax), %rcx
               	addq	$-0x8, %rcx
               	subq	%rax, %rcx
               	cmpq	$0x18, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	xorl	%eax, %eax
               	retq
