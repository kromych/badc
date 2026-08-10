
attribute_statement.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movl	$0x1, %eax
               	movl	$0x3, %eax
               	xorq	%rax, %rax
               	movl	$0x2, %eax
               	movl	$0x4, %eax
               	movl	$0x4, %eax
               	movl	$0x8, %eax
               	xorq	%rax, %rax
               	movl	$0x63, %eax
               	xorq	%rax, %rax
               	retq
