
typeof_expression.x64:	file format elf64-x86-64

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
               	movl	$0x3, %eax
               	movl	$0x7, %eax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movl	$0x4, %ecx
               	movl	$0xa, %ecx
               	movq	%rax, %rcx
               	retq
