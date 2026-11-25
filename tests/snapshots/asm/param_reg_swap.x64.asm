
param_reg_swap.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<core>:
               	movl	(%rcx), %eax
               	movl	0x4(%rcx), %edx
               	movl	0x8(%rcx), %esi
               	movl	0xc(%rcx), %ecx
               	xorq	%rdx, %rax
               	xorq	%rsi, %rax
               	xorq	%rcx, %rax
               	andq	$0xff, %rax
               	movb	%al, (%rdi)
               	retq

<main>:
               	subq	$0x48, %rsp
               	movl	$0x3020100, 0x10(%rsp)  # imm = 0x3020100
               	movl	$0x7060504, 0x14(%rsp)  # imm = 0x7060504
               	movl	$0xb0a0908, 0x18(%rsp)  # imm = 0xB0A0908
               	movl	$0xf0e0d0c, 0x1c(%rsp)  # imm = 0xF0E0D0C
               	xorl	%eax, %eax
               	movb	%al, 0x20(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x8(%rsp), %rdi
               	leaq	0x10(%rsp), %rsi
               	leaq	0x20(%rsp), %rdx
               	callq	<addr>
               	movzbq	0x8(%rsp), %rax
               	addq	$0x48, %rsp
               	retq
