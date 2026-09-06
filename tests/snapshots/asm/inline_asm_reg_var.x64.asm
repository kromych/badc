
inline_asm_reg_var.x64:	file format elf64-x86-64

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

<add_pinned>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%r12, (%rsp)
               	movl	$0x1e, %eax
               	movl	$0xa, %ecx
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdx, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	-0x28(%rbp), %r9
               	movq	-0x20(%rbp), %r12
               	movq	%r9, %rax
               	addq	%r12, %rax
               	movq	-0x30(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x8(%rbp), %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %r12
               	leave
               	retq

<narrow_pinned>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0x1, %eax
               	leaq	-0x10(%rbp), %rcx
               	movq	%rcx, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %r9
               	movl	%r9d, %eax
               	addl	%r9d, %eax
               	movq	-0x20(%rbp), %r10
               	movl	%eax, (%r10)
               	movslq	-0x10(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%r12, (%rsp)
               	movl	$0x1e, %eax
               	movl	$0xa, %ecx
               	leaq	-0x18(%rbp), %rdx
               	movq	%rdx, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	-0x38(%rbp), %r9
               	movq	-0x30(%rbp), %r12
               	movq	%r9, %rax
               	addq	%r12, %rax
               	movq	-0x40(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x18(%rbp), %rax
               	movslq	%eax, %rax
               	cmpl	$0x28, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %r12
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0x10(%rbp), %rcx
               	movq	%rcx, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	-0x38(%rbp), %r9
               	movl	%r9d, %eax
               	addl	%r9d, %eax
               	movq	-0x40(%rbp), %r10
               	movl	%eax, (%r10)
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %r12
               	leave
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %r12
               	leave
               	retq
