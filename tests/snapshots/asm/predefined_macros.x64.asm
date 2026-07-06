
predefined_macros.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rax
               	movsbq	0x3(%rax), %rcx
               	cmpq	$0x20, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movsbq	0x6(%rax), %rcx
               	cmpq	$0x20, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movsbq	0xb(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	0x2(%rax), %rcx
               	cmpq	$0x3a, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movsbq	0x5(%rax), %rcx
               	cmpq	$0x3a, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movsbq	0x8(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x9, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	movl	$0x1, %eax
               	retq
               	movl	$0x2, %eax
               	retq
