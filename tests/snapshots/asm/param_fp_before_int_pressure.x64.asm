
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
               	subq	$0x20, %rsp
               	movq	%r13, (%rsp)
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	movslq	%r8d, %r8
               	movslq	%r9d, %r9
               	imulq	$0x186a0, %rdi, %rax    # imm = 0x186A0
               	movslq	%eax, %rax
               	imulq	$0x2710, %rsi, %rsi     # imm = 0x2710
               	movslq	%esi, %rsi
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	imulq	$0x3e8, %rdx, %rdx      # imm = 0x3E8
               	movslq	%edx, %rdx
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	movslq	(%rcx), %rcx
               	imulq	$0x64, %rcx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	imulq	$0xa, %r8, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	%r9, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%r13, (%rsp)
               	movl	$0x7, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	$0x1, %eax
               	movl	$0x2, %ecx
               	movl	$0x3, %edx
               	leaq	-0x8(%rbp), %rsi
               	movl	$0x4, %edi
               	movl	$0x5, %r8d
               	imulq	$0x186a0, %rax, %rax    # imm = 0x186A0
               	movslq	%eax, %rax
               	imulq	$0x2710, %rcx, %rcx     # imm = 0x2710
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	imulq	$0x3e8, %rdx, %rcx      # imm = 0x3E8
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movslq	(%rsi), %rcx
               	imulq	$0x64, %rcx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	imulq	$0xa, %rdi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	%r8, %rax
               	movslq	%eax, %rax
               	cmpq	$0x1e361, %rax          # imm = 0x1E361
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
