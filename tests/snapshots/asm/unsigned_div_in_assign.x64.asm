
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
               	movq	(%rdi), %rax
               	movq	%rax, %rcx
               	shrq	$0x3, %rcx
               	movabsq	$0x5555555555555556, %rdx # imm = 0x5555555555555556
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	mulq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movabsq	$0x2492492492492493, %rdx # imm = 0x2492492492492493
               	movq	%rdx, %r10
               	pushq	%rax
               	mulq	%r10
               	popq	%rax
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	shrq	%rsi
               	addq	%rsi, %rdx
               	shrq	$0x2, %rdx
               	imulq	$0x7, %rdx, %rdx
               	subq	%rdx, %rax
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	retq
