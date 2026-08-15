
asm_template_mnemonic_not_a_reference.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	nop
               	nop
               	xorq	%rax, %rax
               	retq
