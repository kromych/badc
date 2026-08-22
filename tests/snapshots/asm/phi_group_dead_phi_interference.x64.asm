
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
               	movq	%rax, %rdx
               	movq	%rax, %rcx
               	movq	%rax, %rsi
               	jmp	<addr>
               	leaq	0x1(%rdx), %rcx
               	movq	%rax, %rdx
               	movq	%rax, %rsi
               	movslq	%ecx, %rdx
               	cmpq	$0x5, %rdx
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	retq
