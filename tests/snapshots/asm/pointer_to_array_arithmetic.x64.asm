
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
               	movl	(%rdx), %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movl	0x4(%rdx), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	shrq	$0x3d, %rax
               	addq	%rcx, %rax
               	sarq	$0x3, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
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
