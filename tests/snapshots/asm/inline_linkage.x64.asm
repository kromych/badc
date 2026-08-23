
inline_linkage.x64:	file format elf64-x86-64

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

<einl>:
               	leaq	0x3(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	retq
