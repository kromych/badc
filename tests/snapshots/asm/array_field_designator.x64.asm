
array_field_designator.x64:	file format elf64-x86-64

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
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movslq	0x4(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movslq	0x8(%rax), %rcx
               	cmpq	$0x1e, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movslq	0xc(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movslq	0x10(%rax), %rax
               	cmpq	$0x32, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
