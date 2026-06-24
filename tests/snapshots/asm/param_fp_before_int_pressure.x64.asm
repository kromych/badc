
param_fp_before_int_pressure.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<draw>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	imulq	$0x186a0, %rdi, %rax    # imm = 0x186A0
               	imulq	$0x2710, %rsi, %rsi     # imm = 0x2710
               	addq	%rsi, %rax
               	imulq	$0x3e8, %rdx, %rdx      # imm = 0x3E8
               	addq	%rdx, %rax
               	movslq	(%rcx), %rcx
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	imulq	$0xa, %r8, %rcx
               	addq	%rcx, %rax
               	addq	%r9, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movl	$0x7, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	$0x1, %eax
               	movl	$0x2, %ecx
               	movl	$0x3, %edx
               	leaq	-0x8(%rbp), %rsi
               	movl	$0x4, %edi
               	movl	$0x5, %r8d
               	imulq	$0x186a0, %rax, %rax    # imm = 0x186A0
               	imulq	$0x2710, %rcx, %rcx     # imm = 0x2710
               	addq	%rcx, %rax
               	imulq	$0x3e8, %rdx, %rcx      # imm = 0x3E8
               	addq	%rcx, %rax
               	movslq	(%rsi), %rcx
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	imulq	$0xa, %rdi, %rcx
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	movslq	%eax, %rax
               	cmpq	$0x1e361, %rax          # imm = 0x1E361
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
