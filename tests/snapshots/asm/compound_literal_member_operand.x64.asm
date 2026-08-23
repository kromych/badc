
compound_literal_member_operand.x64:	file format elf64-x86-64

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

<ne_rhs>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	leaq	-0x10(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movzbq	(%rdx), %rax
               	movb	%al, (%rcx)
               	movzbq	0x1(%rdx), %rax
               	movb	%al, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rax
               	movb	%al, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rax
               	movb	%al, 0x3(%rcx)
               	popq	%rax
               	cmpl	$-0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<eq_rhs>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	leaq	-0x10(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movzbq	(%rdx), %rax
               	movb	%al, (%rcx)
               	movzbq	0x1(%rdx), %rax
               	movb	%al, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rax
               	movb	%al, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rax
               	movb	%al, 0x3(%rcx)
               	popq	%rax
               	cmpl	$-0x1, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<add_rhs>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	leaq	-0x10(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movzbq	(%rdx), %rax
               	movb	%al, (%rcx)
               	movzbq	0x1(%rdx), %rax
               	movb	%al, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rax
               	movb	%al, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rax
               	movb	%al, 0x3(%rcx)
               	popq	%rax
               	decq	%rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<swapped>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	popq	%rdx
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpl	$-0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	xorq	%rax, %rax
               	retq
