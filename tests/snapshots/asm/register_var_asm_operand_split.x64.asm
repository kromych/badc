
register_var_asm_operand_split.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<through_rdx>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rdi, -0x18(%rbp)
               	movq	-0x18(%rbp), %rdx
               	movq	%rdx, %rax
               	movq	-0x20(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rdx
               	movq	-0x10(%rbp), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<via_named_rdx>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rdi, -0x18(%rbp)
               	movq	-0x18(%rbp), %rdx
               	movq	%rdx, %rax
               	movq	-0x20(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rdx
               	movq	-0x10(%rbp), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0x2a, %eax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %rdx
               	movq	%rdx, %rax
               	movq	-0x20(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rdx
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x7, %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %rdx
               	movq	%rdx, %rax
               	movq	-0x20(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rdx
               	movq	-0x8(%rbp), %rax
               	cmpq	$-0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7b, %eax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %rdx
               	movq	%rdx, %rax
               	movq	-0x20(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rdx
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x7b, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x5, %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %rdx
               	movq	%rdx, %rax
               	movq	-0x20(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rdx
               	movq	-0x8(%rbp), %rax
               	cmpq	$-0x5, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
