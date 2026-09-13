
inline_asm_pushsection.x64:	file format elf64-x86-64

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

<probe>:
               	nop
               	nop
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<fixup_style>:
               	nop
               	nop
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	nop
               	nop
               	nop
               	nop
               	movl	$0x2a, %eax
               	retq
