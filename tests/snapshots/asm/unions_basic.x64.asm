
unions_basic.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movl	$0x2a, %ecx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdx
               	movq	%rdx, (%rax)
               	movabsq	$0x400c000000000000, %rdx # imm = 0x400C000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, (%rax,%riz)
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x400b333333333333, %rdx # imm = 0x400B333333333333
               	movq	%rdx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movl	$0x4, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x400ccccccccccccd, %rax # imm = 0x400CCCCCCCCCCCCD
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x5, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
