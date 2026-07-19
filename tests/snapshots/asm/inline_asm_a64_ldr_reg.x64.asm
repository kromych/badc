
inline_asm_a64_ldr_reg.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rax
               	movq	0x10(%rax), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq
