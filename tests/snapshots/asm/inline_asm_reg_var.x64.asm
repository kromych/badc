
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
               	subq	$0x50, %rsp
               	movl	$0x1e, %eax
               	movl	$0xa, %ecx
               	leaq	-0x18(%rbp), %rdx
               	movq	%rax, -0x50(%rbp)
               	movq	%r9, -0x48(%rbp)
               	movq	%r12, -0x40(%rbp)
               	movq	%rdx, -0x38(%rbp)
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	-0x30(%rbp), %r9
               	movq	-0x28(%rbp), %r12
               	movq	%r9, %rax
               	addq	%r12, %rax
               	movq	-0x38(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %r9
               	movq	-0x40(%rbp), %r12
               	movq	-0x18(%rbp), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq

<narrow_pinned>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0x1, %eax
               	leaq	-0x10(%rbp), %rcx
               	movq	%rax, -0x30(%rbp)
               	movq	%r9, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %r9
               	movl	%r9d, %eax
               	addl	%r9d, %eax
               	movq	-0x20(%rbp), %r11
               	movl	%eax, (%r11)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %r9
               	movslq	-0x10(%rbp), %rax
               	addq	$0x30, %rsp
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
