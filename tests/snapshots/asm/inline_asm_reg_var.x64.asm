
inline_asm_reg_var.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<add_pinned>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0x1e, %eax
               	movl	$0xa, %ecx
               	leaq	-0x18(%rbp), %rdx
               	pushq	%rax
               	pushq	%r9
               	pushq	%r12
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%rax, %r10
               	pushq	%r10
               	movq	%rcx, %r10
               	pushq	%r10
               	movq	0x8(%rsp), %r9
               	movq	(%rsp), %r12
               	movq	%r9, %rax
               	addq	%r12, %rax
               	movq	0x10(%rsp), %r11
               	movq	%rax, (%r11)
               	addq	$0x18, %rsp
               	popq	%r12
               	popq	%r9
               	popq	%rax
               	movq	-0x18(%rbp), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<narrow_pinned>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, %eax
               	leaq	-0x10(%rbp), %rcx
               	pushq	%rax
               	pushq	%r9
               	movq	%rcx, %r10
               	pushq	%r10
               	movq	%rax, %r10
               	pushq	%r10
               	movq	(%rsp), %r9
               	movl	%r9d, %eax
               	addl	%r9d, %eax
               	movq	0x8(%rsp), %r11
               	movl	%eax, (%r11)
               	addq	$0x10, %rsp
               	popq	%r9
               	popq	%rax
               	movslq	-0x10(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	cmpq	$0x28, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	popq	%rbp
               	retq
