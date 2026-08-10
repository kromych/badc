
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
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x8, %eax
               	retq
               	xorq	%rax, %rax
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x5a, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	xorq	%rax, %rax
               	retq
