
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
               	movq	%r14, 0x18(%rsp)
               	xorq	%r8, %r8
               	jmp	<addr>
               	leaq	-0x40(%rbp), %r9
               	leaq	(%r8,%r8,4), %rbx
               	movslq	%ebx, %rbx
               	movq	%r8, %r12
               	shlq	$0x2, %r12
               	movslq	%r12d, %r12
               	addq	%rcx, %r12
               	movzbq	0x3(%r12), %r13
               	movl	%r13d, %r13d
               	shlq	$0x8, %r13
               	movl	%r13d, %r13d
               	movzbq	0x2(%r12), %r14
               	orq	%r14, %r13
               	movl	%r13d, %r13d
               	shlq	$0x8, %r13
               	movl	%r13d, %r13d
               	movzbq	0x1(%r12), %r14
               	orq	%r14, %r13
               	movl	%r13d, %r13d
               	shlq	$0x8, %r13
               	movl	%r13d, %r13d
               	movzbq	(%r12), %r12
               	orq	%r13, %r12
               	movl	%r12d, (%r9,%rbx,4)
               	leaq	-0x40(%rbp), %r9
               	leaq	0x1(%r8), %rbx
               	movslq	%ebx, %rbx
               	movq	%r8, %r12
               	shlq	$0x2, %r12
               	movslq	%r12d, %r12
               	addq	%rdx, %r12
               	movzbq	0x3(%r12), %r13
               	movl	%r13d, %r13d
               	shlq	$0x8, %r13
               	movl	%r13d, %r13d
               	movzbq	0x2(%r12), %r14
               	orq	%r14, %r13
               	movl	%r13d, %r13d
               	shlq	$0x8, %r13
               	movl	%r13d, %r13d
               	movzbq	0x1(%r12), %r14
               	orq	%r14, %r13
               	movl	%r13d, %r13d
               	shlq	$0x8, %r13
               	movl	%r13d, %r13d
               	movzbq	(%r12), %r12
               	orq	%r13, %r12
               	movl	%r12d, (%r9,%rbx,4)
               	leaq	-0x40(%rbp), %r9
               	leaq	0x6(%r8), %rbx
               	movslq	%ebx, %rbx
               	movq	%r8, %r12
               	shlq	$0x2, %r12
               	movslq	%r12d, %r12
               	addq	%rsi, %r12
               	movzbq	0x3(%r12), %r13
               	movl	%r13d, %r13d
               	shlq	$0x8, %r13
               	movl	%r13d, %r13d
               	movzbq	0x2(%r12), %r14
               	orq	%r14, %r13
               	movl	%r13d, %r13d
               	shlq	$0x8, %r13
               	movl	%r13d, %r13d
               	movzbq	0x1(%r12), %r14
               	orq	%r14, %r13
               	movl	%r13d, %r13d
               	shlq	$0x8, %r13
               	movl	%r13d, %r13d
               	movzbq	(%r12), %r12
               	orq	%r13, %r12
               	movl	%r12d, (%r9,%rbx,4)
               	leaq	-0x40(%rbp), %r9
               	leaq	0xb(%r8), %rbx
               	movslq	%ebx, %rbx
               	leaq	0x10(%rdx), %r12
               	movq	%r8, %r13
               	shlq	$0x2, %r13
               	movslq	%r13d, %r13
               	addq	%r13, %r12
               	movzbq	0x3(%r12), %r13
               	movl	%r13d, %r13d
               	shlq	$0x8, %r13
               	movl	%r13d, %r13d
               	movzbq	0x2(%r12), %r14
               	orq	%r14, %r13
               	movl	%r13d, %r13d
               	shlq	$0x8, %r13
               	movl	%r13d, %r13d
               	movzbq	0x1(%r12), %r14
               	orq	%r14, %r13
               	movl	%r13d, %r13d
               	shlq	$0x8, %r13
               	movl	%r13d, %r13d
               	movzbq	(%r12), %r12
               	orq	%r13, %r12
               	movl	%r12d, (%r9,%rbx,4)
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
               	movq	0x18(%rsp), %r14
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
               	leaq	-0x38(%rbp), %rdx
               	addq	%rax, %rdx
               	movq	%rax, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx)
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
