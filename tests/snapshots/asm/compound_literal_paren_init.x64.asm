
compound_literal_paren_init.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x40(%rbp), %rcx
               	leaq	<rip>, %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	movq	0x18(%rax), %rdx
               	movq	%rdx, 0x18(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rdx), %rcx
               	movq	%rcx, 0x10(%rax)
               	movq	0x18(%rdx), %rcx
               	movq	%rcx, 0x18(%rax)
               	popq	%rcx
               	movq	%rax, %rdx
               	leaq	<rip>, %rdx
               	movslq	0x18(%rdx), %rdx
               	cmpl	$-0x1, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	0x18(%rcx), %rcx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	0x18(%rax), %rcx
               	cmpl	$0x9, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	popq	%rdx
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
