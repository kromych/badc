
phi_group_dead_phi_interference.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rcx, %rcx
               	xorq	%rdx, %rdx
               	xorq	%rax, %rax
               	movq	%rcx, %rsi
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	leaq	0x1(%rsi), %rax
               	movq	%rcx, %rsi
               	movslq	%eax, %rsi
               	cmpq	$0x5, %rsi
               	jl	<addr>
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	retq
