
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
               	movq	%rax, %rdi
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	incq	%rcx
               	movq	%rax, %rdx
               	movq	%rax, %rdi
               	cmpl	$0x5, %ecx
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	retq
