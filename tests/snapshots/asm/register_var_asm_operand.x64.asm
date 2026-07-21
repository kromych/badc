
register_var_asm_operand.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<through_r12>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%r12, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rdi, -0x18(%rbp)
               	movq	-0x18(%rbp), %r12
               	movq	%r12, %rax
               	movq	-0x20(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %r12
               	movq	-0x10(%rbp), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movl	$0x2a, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, -0x50(%rbp)
               	movq	%r12, -0x48(%rbp)
               	movq	%rcx, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	-0x38(%rbp), %r12
               	movq	%r12, %rax
               	movq	-0x40(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %r12
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x7, %rax
               	leaq	-0x28(%rbp), %rcx
               	movq	%rax, -0x50(%rbp)
               	movq	%r12, -0x48(%rbp)
               	movq	%rcx, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	-0x38(%rbp), %r12
               	movq	%r12, %rax
               	movq	-0x40(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %r12
               	movq	-0x28(%rbp), %rax
               	cmpq	$-0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
