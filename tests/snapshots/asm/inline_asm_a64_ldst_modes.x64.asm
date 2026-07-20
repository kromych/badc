
inline_asm_a64_ldst_modes.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rcx
               	movq	0x18(%rax), %rsi
               	leaq	(%rdx,%rcx), %rdi
               	addq	%rcx, %rdi
               	addq	%rdi, %rdx
               	subq	%rsi, %rcx
               	addq	%rdx, %rcx
               	addq	%rsi, %rcx
               	movq	(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq
