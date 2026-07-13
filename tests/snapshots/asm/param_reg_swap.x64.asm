
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
               	movl	%eax, %eax
               	retq

<core>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%rdi, %r14
               	movq	%rcx, %r12
               	movq	%rsi, %rbx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rdi
               	leaq	(%rax,%rax,4), %rcx
               	movslq	%ecx, %r8
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	movslq	%ecx, %rcx
               	addq	%r12, %rcx
               	movzbq	0x3(%rcx), %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	0x2(%rcx), %r13
               	orq	%r13, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	0x1(%rcx), %r13
               	orq	%r13, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	(%rcx), %rcx
               	orq	%r9, %rcx
               	movl	%ecx, %ecx
               	movl	%ecx, (%rdi,%r8,4)
               	leaq	-0x40(%rbp), %rdi
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %r8
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	movslq	%ecx, %rcx
               	addq	%rdx, %rcx
               	movzbq	0x3(%rcx), %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	0x2(%rcx), %r13
               	orq	%r13, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	0x1(%rcx), %r13
               	orq	%r13, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	(%rcx), %rcx
               	orq	%r9, %rcx
               	movl	%ecx, %ecx
               	movl	%ecx, (%rdi,%r8,4)
               	leaq	-0x40(%rbp), %rdi
               	leaq	0x6(%rax), %rcx
               	movslq	%ecx, %r8
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	movslq	%ecx, %rcx
               	addq	%rbx, %rcx
               	movzbq	0x3(%rcx), %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	0x2(%rcx), %r13
               	orq	%r13, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	0x1(%rcx), %r13
               	orq	%r13, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	(%rcx), %rcx
               	orq	%r9, %rcx
               	movl	%ecx, %ecx
               	movl	%ecx, (%rdi,%r8,4)
               	leaq	-0x40(%rbp), %rdi
               	leaq	0xb(%rax), %rcx
               	movslq	%ecx, %r8
               	leaq	0x10(%rdx), %r9
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	movslq	%ecx, %rcx
               	addq	%r9, %rcx
               	movzbq	0x3(%rcx), %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	0x2(%rcx), %r13
               	orq	%r13, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	0x1(%rcx), %r13
               	orq	%r13, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	(%rcx), %rcx
               	orq	%r9, %rcx
               	movl	%ecx, %ecx
               	movl	%ecx, (%rdi,%r8,4)
               	leaq	0x1(%rsi), %rax
               	movslq	%eax, %rsi
               	cmpq	$0x4, %rsi
               	jl	<addr>
               	xorq	%rcx, %rcx
               	leaq	-0x40(%rbp), %rax
               	movl	(%rax), %edx
               	leaq	-0x40(%rbp), %rax
               	movl	0x14(%rax), %eax
               	xorq	%rax, %rdx
               	leaq	-0x40(%rbp), %rax
               	movl	0x28(%rax), %eax
               	xorq	%rax, %rdx
               	leaq	-0x40(%rbp), %rax
               	movl	0x3c(%rax), %eax
               	xorq	%rdx, %rax
               	andq	$0xff, %rax
               	movb	%al, (%r14)
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	%rcx, %rax
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
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x38(%rbp), %rdx
               	addq	%rcx, %rdx
               	movq	%rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x20, %rcx
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
               	addb	%al, 0x41(%rdx)
