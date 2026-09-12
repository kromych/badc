
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
               	jmp	<addr>
               	movslq	%eax, %rax
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	retq
