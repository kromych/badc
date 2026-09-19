
overaligned_automatic16.x64:	file format elf64-x86-64

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

<probe_even>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movslq	%edi, %rdi
               	movq	%rdi, %rcx
               	sarq	$0x3f, %rcx
               	leaq	-0x60(%rbp), %rax
               	movq	%rdi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x50(%rbp), %rcx
               	leaq	0x1(%rdi), %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, (%rcx)
               	leaq	0x2(%rdi), %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x3(%rdi), %rdx
               	movslq	%edx, %r8
               	movq	%r8, %r9
               	sarq	$0x3f, %r9
               	movq	%r8, (%rsi)
               	movq	%r9, 0x8(%rsi)
               	movq	%rax, %r9
               	andq	$0xf, %r9
               	andq	$0xf, %rcx
               	orq	%r9, %rcx
               	andq	$0xf, %rsi
               	orq	%rsi, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rsi
               	orq	$0x1, %rsi
               	movl	%esi, (%rcx)
               	movq	(%rax), %rax
               	cmpq	%rdi, %rax
               	jne	<addr>
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	movq	%rdi, %rax
               	shlq	%rax
               	addq	$0x3, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	%r8, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	orq	$0x2, %rcx
               	movl	%ecx, (%rax)
               	leave
               	retq

<probe_odd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movslq	%edi, %rdi
               	movq	%rdi, -0x38(%rbp)
               	movq	-0x38(%rbp), %rcx
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	leaq	-0x70(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x60(%rbp), %rcx
               	movq	-0x38(%rbp), %rdx
               	incq	%rdx
               	movq	%rdx, (%rcx)
               	movq	-0x38(%rbp), %rdx
               	addq	$0x2, %rdx
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x50(%rbp), %rdx
               	movq	-0x38(%rbp), %rsi
               	addq	$0x3, %rsi
               	movq	%rsi, %r8
               	sarq	$0x3f, %r8
               	movq	%rsi, (%rdx)
               	movq	%r8, 0x8(%rdx)
               	movq	%rax, %rsi
               	andq	$0xf, %rsi
               	andq	$0xf, %rcx
               	orq	%rsi, %rcx
               	andq	$0xf, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	orq	$0x4, %rdx
               	movl	%edx, (%rcx)
               	movq	(%rax), %rax
               	cmpq	%rdi, %rax
               	jne	<addr>
               	leaq	-0x60(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	movq	%rdi, %rax
               	shlq	%rax
               	addq	$0x3, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %rcx
               	leaq	0x3(%rdi), %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	orq	$0x8, %rcx
               	movl	%ecx, (%rax)
               	leave
               	retq

<walk>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	movslq	%edi, %rbx
               	leaq	-0x18(%rbp), %rcx
               	imulq	$0x55555556, %rbx, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	leaq	(%rax,%rax,2), %rax
               	movq	%rbx, %rdx
               	subq	%rax, %rdx
               	movq	%rdx, %rax
               	shlq	$0x3, %rax
               	addq	%rcx, %rax
               	movq	%rbx, (%rax)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	testl	%ebx, %ebx
               	jle	<addr>
               	leaq	-0x1(%rbx), %rdi
               	callq	<addr>
               	leaq	-0x18(%rbp), %rcx
               	imulq	$0x55555556, %rbx, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	leaq	(%rax,%rax,2), %rax
               	movq	%rbx, %rdx
               	subq	%rax, %rdx
               	movq	%rdx, %rax
               	shlq	$0x3, %rax
               	addq	%rcx, %rax
               	movq	(%rax), %rax
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x6, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbp
               	retq
