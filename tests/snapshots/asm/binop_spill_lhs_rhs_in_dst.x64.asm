
binop_spill_lhs_rhs_in_dst.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sum_at_high>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	movq	%rsi, %r8
               	movslq	%r8d, %r8
               	movslq	%edx, %rdx
               	movslq	(%rdi,%rdx,4), %rax
               	xorq	%rsi, %rsi
               	movslq	%r8d, %rcx
               	cmpq	%rdx, %rcx
               	jg	<addr>
               	jmp	<addr>
               	movslq	%r8d, %rcx
               	movq	%rcx, %r8
               	incq	%r8
               	jmp	<addr>
               	movslq	%esi, %rcx
               	movslq	%r8d, %rsi
               	movslq	(%rdi,%rsi,4), %rsi
               	addq	%rsi, %rcx
               	movslq	%ecx, %rsi
               	jmp	<addr>
               	movslq	%esi, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %r13
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%r13, (%rsp)
               	leaq	-0x18(%rbp), %rax
               	xorq	%rsi, %rsi
               	movl	$0xc, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x4, %edx
               	movl	$0x7, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0xf, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x5, %ecx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0xa, %ecx
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rdi
               	callq	<addr>
               	movq	(%rsp), %r13
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
