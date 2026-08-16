
phi_group_dead_phi_interference.x64:	file format elf64-x86-64

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
               	xorq	%rax, %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, %rsi
               	movq	%rax, %rcx
               	movq	%rax, %rdi
               	jmp	<addr>
               	leaq	0x1(%rsi), %rcx
               	movq	%rdx, %rsi
               	movq	%rax, %rdi
               	movslq	%ecx, %rsi
               	cmpq	$0x5, %rsi
               	jl	<addr>
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	retq
