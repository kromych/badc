
pointer_to_array_arithmetic.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	leaq	<rip>, %rax # <addr>
               	leaq	0x10(%rax), %rdx
               	movq	%rdx, %rsi
               	subq	%rax, %rsi
               	cmpq	$0x10, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	0x8(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x8, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpq	$0x10, %rsi
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	(%rdx), %esi
               	cmpl	$0x4, %esi
               	jne	<addr>
               	movl	0x4(%rdx), %edx
               	cmpl	$0x5, %edx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	shrq	$0x3d, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	<rip>, %ecx # <addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	cmpl	$0x3, %edx
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
