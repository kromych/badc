
nested_designator_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movslq	0x4(%rax), %rcx
               	cmpq	$0x2, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movslq	0x8(%rax), %rcx
               	cmpq	$0x3, %rcx
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movslq	0xc(%rax), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	xorq	%rax, %rax
               	retq
