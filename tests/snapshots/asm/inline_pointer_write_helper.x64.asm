
inline_pointer_write_helper.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movzbq	0x8(%rcx), %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movb	%dl, 0xb(%rax)
               	popq	%rdx
               	leaq	-0x10(%rbp), %rax
               	movl	$0x28, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movslq	0x4(%rax), %rcx
               	addq	$0x5, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x10(%rbp), %rax
               	movslq	0x8(%rax), %rcx
               	decq	%rcx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rcx), %rdx
               	movslq	0x8(%rax), %rsi
               	movl	%esi, (%rcx)
               	movl	%edx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x28, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x20(%rbp), %rax
               	addq	$0x0, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	movslq	0x4(%rax), %rcx
               	addq	$0xb, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x20(%rbp), %rax
               	movslq	0x8(%rax), %rcx
               	addq	$0x15, %rcx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x20(%rbp), %rax
               	movslq	0xc(%rax), %rcx
               	addq	$0x1f, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0xb, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x15, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0x1f, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
