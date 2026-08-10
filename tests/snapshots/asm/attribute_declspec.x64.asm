
attribute_declspec.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<exported>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	xorq	%rax, %rax
               	retq
