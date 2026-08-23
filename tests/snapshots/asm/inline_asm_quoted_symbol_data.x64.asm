
inline_asm_quoted_symbol_data.x64:	file format elf64-x86-64

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

<record>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	movl	$0x2a, %eax
               	retq
