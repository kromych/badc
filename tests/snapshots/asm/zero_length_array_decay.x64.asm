
zero_length_array_decay.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rax
               	cmpq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	cmpq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	cmpq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x5a, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	xorq	%rax, %rax
               	retq
