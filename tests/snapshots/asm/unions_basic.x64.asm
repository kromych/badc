
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
               	movl	$0x2a, -0x8(%rbp)
               	xorl	%eax, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	<rip>, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$0x400c000000000000, %rcx # imm = 0x400C000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	movabsq	$0x400b333333333333, %rcx # imm = 0x400B333333333333
               	movq	%rcx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movsd	-0x8(%rbp), %xmm0
               	movabsq	$0x400ccccccccccccd, %rcx # imm = 0x400CCCCCCCCCCCCD
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leave
               	retq
