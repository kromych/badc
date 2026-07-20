
param_fp_before_int_pressure.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movl	$0x7, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rcx), %rax
               	imulq	$0x64, %rax, %rax
               	addq	$0x1e078, %rax          # imm = 0x1E078
               	addq	$0x28, %rax
               	addq	$0x5, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
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
