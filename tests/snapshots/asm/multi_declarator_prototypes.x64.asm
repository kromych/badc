
multi_declarator_prototypes.x64:	file format elf64-x86-64

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

<f>:
               	movq	%rdi, %rax
               	retq

<g>:
               	movq	%rdi, %rax
               	shlq	%rax
               	retq

<main>:
               	leaq	<rip>, %rax # <addr>
               	movl	$0xa, (%rax)
               	xorl	%eax, %eax
               	retq
