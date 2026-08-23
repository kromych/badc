
constfold_branch_through_phi.x64:	file format elf64-x86-64

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
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movl	$0x8, %ecx
               	movq	%rcx, %rdx
               	movl	$0x2, %eax
               	movl	$0xa, %eax
               	movq	%rax, %rdx
               	movl	$0x64, %edx
               	movq	%rdx, %rsi
               	movabsq	$-0x2, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	xorq	%rax, %rax
               	retq
