
binop_spill_lhs_rhs_in_dst.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sum_at_high>:
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
               	leaq	0x1(%rcx), %r8
               	jmp	<addr>
               	movslq	%r8d, %rcx
               	movslq	(%rdi,%rcx,4), %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rsi
               	jmp	<addr>
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
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
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
