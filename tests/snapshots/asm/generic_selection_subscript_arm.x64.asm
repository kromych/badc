
generic_selection_subscript_arm.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<as_m>:
               	movl	$0x1, %eax
               	retq

<as_n>:
               	movl	$0x2, %eax
               	retq

<main>:
               	xorq	%rax, %rax
               	retq
