
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
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rdx # <addr>
               	leaq	(%rcx,%rax), %rsi
               	addq	%rax, %rsi
               	addq	%rsi, %rcx
               	subq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	movq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	retq
