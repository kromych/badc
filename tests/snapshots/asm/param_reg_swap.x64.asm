
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
               	movslq	%r8d, %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%r8d, %rax
               	movq	%rax, %r8
               	incq	%r8
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
               	movq	%r8, %r9
               	incq	%r9
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
               	movq	%r8, %r9
               	addq	$0x6, %r9
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
               	movq	%r8, %r9
               	addq	$0xb, %r9
               	movslq	%r9d, %r9
               	movq	%rdx, %rbx
               	addq	$0x10, %rbx
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
               	jmp	<addr>
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
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x10, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	andq	$0xff, %rdx
               	movb	%dl, (%rax)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x20, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	-0x38(%rbp), %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	andq	$0xff, %rdx
               	movb	%dl, (%rax)
               	jmp	<addr>
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
