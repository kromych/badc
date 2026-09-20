
parenthesized_function_declarator.x64:	file format elf64-x86-64

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

<one>:
               	leaq	0x1(%rdi), %rax
               	retq

<two>:
               	leaq	<rip>, %rax
               	movq	%rdi, %rcx
               	shlq	%rcx
               	movl	%ecx, (%rax)
               	retq

<main>:
               	leaq	<rip>, %rax
               	movl	$0xa, (%rax)
               	xorl	%eax, %eax
               	retq
