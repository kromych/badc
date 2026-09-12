
local_aggregate_runtime_init.x64:	file format elf64-x86-64

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

<opaque>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x28(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	$0x0, 0x10(%rax)
               	leaq	<rip>, %rbx
               	movslq	(%rbx), %rcx
               	movl	%ecx, (%rax)
               	movl	$0x68, %ecx
               	movb	%cl, 0x4(%rax)
               	movl	$0x6f, %ecx
               	movb	%cl, 0x5(%rax)
               	movl	$0x6c, %ecx
               	movb	%cl, 0x6(%rax)
               	movl	$0x61, %ecx
               	movb	%cl, 0x7(%rax)
               	xorq	%rcx, %rcx
               	leaq	-0x28(%rbp), %rax
               	movb	%cl, 0x8(%rax)
               	movb	%cl, 0x9(%rax)
               	movb	%cl, 0xa(%rax)
               	movb	%cl, 0xb(%rax)
               	movb	%cl, 0xc(%rax)
               	movb	%cl, 0xd(%rax)
               	leaq	-0x28(%rbp), %rdi
               	movq	%rbx, 0x10(%rdi)
               	callq	<addr>
               	movslq	(%rax), %rcx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movsbq	0x4(%rax), %rcx
               	cmpl	$0x68, %ecx
               	jne	<addr>
               	movsbq	0x5(%rax), %rcx
               	cmpl	$0x6f, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsbq	0x6(%rax), %rcx
               	cmpl	$0x6c, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsbq	0x7(%rax), %rcx
               	cmpl	$0x61, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movsbq	0x8(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsbq	0xd(%rax), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	0x10(%rax), %rax
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movl	$0x0, 0x8(%rdi)
               	movslq	(%rbx), %rax
               	movl	%eax, (%rdi)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movl	%eax, 0x4(%rdi)
               	movl	$0x5, %eax
               	movl	%eax, 0x8(%rdi)
               	callq	<addr>
               	movslq	(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	cmpl	$0x7, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x8(%rax), %rax
               	cmpl	$0x5, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rcx
               	cmpl	$0x6f, %ecx
               	jne	<addr>
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x6b, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
