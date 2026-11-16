
inline_asm_a64_ldst_modes.x64:	file format elf64-x86-64

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
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	leaq	(%rax,%rcx), %rsi
               	addq	%rcx, %rsi
               	addq	%rax, %rsi
               	subq	%rdx, %rcx
               	addq	%rsi, %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	retq
