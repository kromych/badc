
short_types.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rax, %rax
               	movabsq	$-0x8000, %rax          # imm = 0x8000
               	xorq	%rax, %rax
               	movl	$0x2a, %eax
               	retq
