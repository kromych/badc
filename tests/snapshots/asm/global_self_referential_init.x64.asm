
global_self_referential_init.x64:	file format elf64-x86-64

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

<drop>:
               	movq	%rdi, %rax
               	negq	%rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax # <addr>
               	leaq	0x10(%rax), %rcx
               	movq	(%rcx), %rdx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	0x30(%rax), %rcx
               	movq	(%rcx), %rdx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rcx # <addr>
               	leaq	0x50(%rax), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rsi # <addr>
               	cmpq	%rdx, %rsi
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	subq	%rax, %rcx
               	addq	%rcx, %rax
               	movl	(%rax), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x3, %edi
               	callq	*%rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
