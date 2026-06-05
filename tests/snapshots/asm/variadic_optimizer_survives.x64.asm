
variadic_optimizer_survives.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	0x10(%rbp), %rcx
               	leaq	0x10(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %r13
               	movq	(%r13), %rax
               	leaq	0x10(%rax), %rax
               	movq	%rax, (%r13)
               	leaq	-0x10(%rax), %rax
               	movslq	(%rax), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rcx, %r13
               	movq	(%r13), %rcx
               	leaq	0x10(%rcx), %rcx
               	movq	%rcx, (%r13)
               	leaq	-0x10(%rcx), %rcx
               	movslq	(%rcx), %rcx
               	leaq	-0x8(%rbp), %rdx
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x7, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi
               	movl	$0x2a, %esi
               	movl	$0x7, %edx
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	callq	<addr>
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
