
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
               	subq	$0x20, %rsp
               	movq	%r12, (%rsp)
               	movl	$0x1e, %r9d
               	movl	$0xa, %r12d
               	movq	%r9, %rax
               	addq	%r12, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %r12
               	leave
               	retq

<narrow_pinned>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, %r9d
               	movl	%r9d, %eax
               	addl	%r9d, %eax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%r12, (%rsp)
               	movl	$0x1e, %r9d
               	movl	$0xa, %r12d
               	movq	%r9, %rax
               	addq	%r12, %rax
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %rax
               	movslq	%eax, %rax
               	cmpl	$0x28, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %r12
               	leave
               	retq
               	movl	$0x1, %r9d
               	movl	%r9d, %eax
               	addl	%r9d, %eax
               	movl	%eax, -0x10(%rbp)
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
