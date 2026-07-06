
param_reg_swap.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<ld32>:
               	movzbq	0x3(%rdi), %rax
               	movl	%eax, %eax
               	shlq	$0x8, %rax
               	movl	%eax, %eax
               	movzbq	0x2(%rdi), %rcx
               	orq	%rcx, %rax
               	movl	%eax, %eax
               	shlq	$0x8, %rax
               	movl	%eax, %eax
               	movzbq	0x1(%rdi), %rcx
               	orq	%rcx, %rax
               	movl	%eax, %eax
               	shlq	$0x8, %rax
               	movl	%eax, %eax
               	movzbq	(%rdi), %rcx
               	orq	%rcx, %rax
               	retq

<core>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	xorq	%r8, %r8
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rax
               	leaq	(%r8,%r8,4), %r9
               	movslq	%r9d, %r9
               	movq	%r8, %rbx
               	shlq	$0x2, %rbx
               	movslq	%ebx, %rbx
               	addq	%rcx, %rbx
               	movzbq	0x3(%rbx), %r12
               	movl	%r12d, %r12d
               	shlq	$0x8, %r12
               	movl	%r12d, %r12d
               	movzbq	0x2(%rbx), %r13
               	orq	%r13, %r12
               	movl	%r12d, %r12d
               	shlq	$0x8, %r12
               	movl	%r12d, %r12d
               	movzbq	0x1(%rbx), %r13
               	orq	%r13, %r12
               	movl	%r12d, %r12d
               	shlq	$0x8, %r12
               	movl	%r12d, %r12d
               	movzbq	(%rbx), %rbx
               	orq	%r12, %rbx
               	movl	%ebx, (%rax,%r9,4)
               	leaq	-0x40(%rbp), %rax
               	leaq	0x1(%r8), %r9
               	movslq	%r9d, %r9
               	movq	%r8, %rbx
               	shlq	$0x2, %rbx
               	movslq	%ebx, %rbx
               	addq	%rdx, %rbx
               	movzbq	0x3(%rbx), %r12
               	movl	%r12d, %r12d
               	shlq	$0x8, %r12
               	movl	%r12d, %r12d
               	movzbq	0x2(%rbx), %r13
               	orq	%r13, %r12
               	movl	%r12d, %r12d
               	shlq	$0x8, %r12
               	movl	%r12d, %r12d
               	movzbq	0x1(%rbx), %r13
               	orq	%r13, %r12
               	movl	%r12d, %r12d
               	shlq	$0x8, %r12
               	movl	%r12d, %r12d
               	movzbq	(%rbx), %rbx
               	orq	%r12, %rbx
               	movl	%ebx, (%rax,%r9,4)
               	leaq	-0x40(%rbp), %rax
               	leaq	0x6(%r8), %r9
               	movslq	%r9d, %r9
               	movq	%r8, %rbx
               	shlq	$0x2, %rbx
               	movslq	%ebx, %rbx
               	addq	%rsi, %rbx
               	movzbq	0x3(%rbx), %r12
               	movl	%r12d, %r12d
               	shlq	$0x8, %r12
               	movl	%r12d, %r12d
               	movzbq	0x2(%rbx), %r13
               	orq	%r13, %r12
               	movl	%r12d, %r12d
               	shlq	$0x8, %r12
               	movl	%r12d, %r12d
               	movzbq	0x1(%rbx), %r13
               	orq	%r13, %r12
               	movl	%r12d, %r12d
               	shlq	$0x8, %r12
               	movl	%r12d, %r12d
               	movzbq	(%rbx), %rbx
               	orq	%r12, %rbx
               	movl	%ebx, (%rax,%r9,4)
               	leaq	-0x40(%rbp), %rax
               	leaq	0xb(%r8), %r9
               	movslq	%r9d, %r9
               	leaq	0x10(%rdx), %rbx
               	movq	%r8, %r12
               	shlq	$0x2, %r12
               	movslq	%r12d, %r12
               	addq	%r12, %rbx
               	movzbq	0x3(%rbx), %r12
               	movl	%r12d, %r12d
               	shlq	$0x8, %r12
               	movl	%r12d, %r12d
               	movzbq	0x2(%rbx), %r13
               	orq	%r13, %r12
               	movl	%r12d, %r12d
               	shlq	$0x8, %r12
               	movl	%r12d, %r12d
               	movzbq	0x1(%rbx), %r13
               	orq	%r13, %r12
               	movl	%r12d, %r12d
               	shlq	$0x8, %r12
               	movl	%r12d, %r12d
               	movzbq	(%rbx), %rbx
               	orq	%r12, %rbx
               	movl	%ebx, (%rax,%r9,4)
               	movslq	%r8d, %rax
               	leaq	0x1(%rax), %r8
               	movslq	%r8d, %rax
               	cmpq	$0x4, %rax
               	jl	<addr>
               	xorq	%rax, %rax
               	leaq	-0x40(%rbp), %rcx
               	movl	(%rcx), %ecx
               	leaq	-0x40(%rbp), %rdx
               	movl	0x14(%rdx), %edx
               	xorq	%rdx, %rcx
               	leaq	-0x40(%rbp), %rdx
               	movl	0x28(%rdx), %edx
               	xorq	%rdx, %rcx
               	leaq	-0x40(%rbp), %rdx
               	movl	0x3c(%rdx), %edx
               	xorq	%rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdi)
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x18(%rbp), %rax
               	addq	$0x0, %rax
               	xorq	%rcx, %rcx
               	movb	%cl, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x1, %ecx
               	movb	%cl, 0x1(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x2, %ecx
               	movb	%cl, 0x2(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x3, %ecx
               	movb	%cl, 0x3(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x4, %ecx
               	movb	%cl, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x5, %ecx
               	movb	%cl, 0x5(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x6, %ecx
               	movb	%cl, 0x6(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x7, %ecx
               	movb	%cl, 0x7(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x8, %ecx
               	movb	%cl, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x9, %ecx
               	movb	%cl, 0x9(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0xa, %ecx
               	movb	%cl, 0xa(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0xb, %ecx
               	movb	%cl, 0xb(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0xc, %ecx
               	movb	%cl, 0xc(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0xd, %ecx
               	movb	%cl, 0xd(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0xe, %ecx
               	movb	%cl, 0xe(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0xf, %ecx
               	movb	%cl, 0xf(%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x38(%rbp), %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	andq	$0xff, %rdx
               	movb	%dl, (%rax)
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x20, %rax
               	jl	<addr>
               	leaq	-0x8(%rbp), %rdi
               	leaq	-0x18(%rbp), %rsi
               	leaq	-0x38(%rbp), %rdx
               	leaq	<rip>, %rcx
               	callq	<addr>
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
