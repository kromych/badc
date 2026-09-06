
compound_literal_array_init.x64:	file format elf64-x86-64

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
               	addq	$0x0, %rax
               	movzbq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	movzbq	0x1(%rax), %rax
               	cmpl	$0x10, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x2(%rax), %rax
               	cmpl	$0x18, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x3(%rax), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x4(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x5(%rax), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x6, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	movzbq	0x1(%rax), %rcx
               	movzbq	0x5(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x12, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorq	%rax, %rax
               	retq
