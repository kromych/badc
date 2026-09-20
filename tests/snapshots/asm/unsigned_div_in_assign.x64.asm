
unsigned_div_in_assign.x64:	file format elf64-x86-64

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

<outer>:
               	movq	(%rdi), %rcx
               	movq	%rcx, %rax
               	shrq	$0x3, %rax
               	movabsq	$0x5555555555555556, %rsi # imm = 0x5555555555555556
               	mulq	%rsi
               	movq	%rdx, %rsi
               	movabsq	$0x2492492492492493, %rdi # imm = 0x2492492492492493
               	movq	%rcx, %rax
               	mulq	%rdi
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	shrq	%rax
               	addq	%rdx, %rax
               	shrq	$0x2, %rax
               	imulq	$0x7, %rax, %rax
               	subq	%rax, %rcx
               	imulq	$0x64, %rsi, %rax
               	addq	%rcx, %rax
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
