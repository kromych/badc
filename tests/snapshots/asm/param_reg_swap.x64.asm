
param_reg_swap.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movl	$0x3020100, -0x30(%rbp) # imm = 0x3020100
               	movl	$0x7060504, -0x2c(%rbp) # imm = 0x7060504
               	movl	$0xb0a0908, -0x28(%rbp) # imm = 0xB0A0908
               	movl	$0xf0e0d0c, -0x24(%rbp) # imm = 0xF0E0D0C
               	xorl	%eax, %eax
               	movb	%al, -0x20(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x38(%rbp), %rdi
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdx
               	leaq	<rip>, %rcx # <addr>
               	callq	<addr>
               	movzbq	-0x38(%rbp), %rax
               	leave
               	retq
