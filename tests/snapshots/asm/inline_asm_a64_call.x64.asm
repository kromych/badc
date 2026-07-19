
inline_asm_a64_call.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<bump>:
               	leaq	<rip>, %rax
               	movl	$0x2a, %ecx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	retq

<main>:
               	leaq	<rip>, %rax
               	movl	$0x2a, %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	retq
