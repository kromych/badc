
compound_literal_of_pointer_type_is_an_object.x64:	file format elf64-x86-64

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

<h>:
               	movl	$0x2a, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	$0x7, -0x40(%rbp)
               	leaq	-0x38(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rsi
               	leaq	0x1(%rax), %rdi
               	movq	%rdi, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x40(%rbp), %rdi
               	movq	%rdi, -0x18(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	cmpq	%rax, %rsi
               	je	<addr>
               	movq	-0x30(%rbp), %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movq	-0x28(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x69, %eax
               	jne	<addr>
               	movq	-0x20(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x6c, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	-0x18(%rbp), %rax
               	movl	(%rax), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	movq	%rax, -0x8(%rbp)
               	movl	(%rax), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	-0x30(%rbp), %rax
               	addq	$0x2, %rax
               	movq	%rax, -0x30(%rbp)
               	movsbq	(%rax), %rax
               	cmpl	$0x74, %eax
               	jne	<addr>
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	cmpq	%rax, %rcx
               	je	<addr>
               	movq	-0x18(%rbp), %rax
               	callq	*%rax
               	cmpq	$0x2a, %rax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	callq	*%rax
               	cmpq	$0x2a, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	callq	*%rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, -0x8(%rbp)
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	jne	<addr>
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, -0x8(%rbp)
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x3, %eax
               	leave
               	retq
