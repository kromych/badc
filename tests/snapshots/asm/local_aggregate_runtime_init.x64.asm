
local_aggregate_runtime_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<opaque>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x28(%rbp), %rcx
               	xorq	%rax, %rax
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	movq	%rax, 0x10(%rcx)
               	leaq	<rip>, %rbx
               	movslq	(%rbx), %rcx
               	leaq	-0x28(%rbp), %rdx
               	movl	%ecx, (%rdx)
               	movl	$0x68, %edx
               	leaq	-0x28(%rbp), %rcx
               	movb	%dl, 0x4(%rcx)
               	movl	$0x6f, %edx
               	leaq	-0x28(%rbp), %rcx
               	movb	%dl, 0x5(%rcx)
               	movl	$0x6c, %edx
               	leaq	-0x28(%rbp), %rcx
               	movb	%dl, 0x6(%rcx)
               	movl	$0x61, %edx
               	leaq	-0x28(%rbp), %rcx
               	movb	%dl, 0x7(%rcx)
               	leaq	-0x28(%rbp), %rcx
               	movb	%al, 0x8(%rcx)
               	leaq	-0x28(%rbp), %rcx
               	movb	%al, 0x9(%rcx)
               	leaq	-0x28(%rbp), %rcx
               	movb	%al, 0xa(%rcx)
               	leaq	-0x28(%rbp), %rcx
               	movb	%al, 0xb(%rcx)
               	leaq	-0x28(%rbp), %rcx
               	movb	%al, 0xc(%rcx)
               	leaq	-0x28(%rbp), %rcx
               	movb	%al, 0xd(%rcx)
               	leaq	-0x28(%rbp), %rax
               	movq	%rbx, 0x10(%rax)
               	leaq	-0x28(%rbp), %rdi
               	callq	<addr>
               	movslq	(%rax), %rcx
               	cmpq	$0x3, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movsbq	0x4(%rax), %rcx
               	cmpq	$0x68, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsbq	0x5(%rax), %rcx
               	cmpq	$0x6f, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	0x6(%rax), %rcx
               	cmpq	$0x6c, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsbq	0x7(%rax), %rcx
               	cmpq	$0x61, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movsbq	0x8(%rax), %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsbq	0xd(%rax), %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	0x10(%rax), %rax
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movl	%ecx, 0x8(%rax)
               	movslq	(%rbx), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	leaq	-0x10(%rbp), %rax
               	movl	%ecx, 0x4(%rax)
               	movl	$0x5, %ecx
               	leaq	-0x10(%rbp), %rax
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x3, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	0x4(%rcx), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	0x8(%rcx), %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rax
               	cmpq	$0x6f, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	0x1(%rcx), %rax
               	cmpq	$0x6b, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
