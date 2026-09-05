
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
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rdi
               	leaq	-0x40(%rbp), %rax
               	movq	%rdi, (%rax)
               	movq	%rdi, %rcx
               	sarq	$0x3f, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x80(%rbp), %r8
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r8)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r8)
               	popq	%rcx
               	movq	%r8, %rcx
               	leaq	-0x70(%rbp), %rcx
               	leaq	0x1(%rdi), %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, (%rcx)
               	leaq	0x2(%rdi), %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x60(%rbp), %r9
               	leaq	0x3(%rdi), %rdx
               	movslq	%edx, %rsi
               	movq	%rsi, (%rax)
               	movq	%rsi, %rbx
               	sarq	$0x3f, %rbx
               	movq	%rbx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r9)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r9)
               	popq	%rcx
               	movq	%r9, %rax
               	movq	%r8, %rax
               	andq	$0xf, %rax
               	andq	$0xf, %rcx
               	orq	%rcx, %rax
               	movq	%r9, %rcx
               	andq	$0xf, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	orq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	%rdi, %rax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x70(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	movq	%rdi, %rax
               	shlq	%rax
               	addq	$0x3, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x60(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	%rsi, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	orq	$0x2, %rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>

<probe_odd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movslq	%edi, %rdi
               	movq	%rdi, -0x38(%rbp)
               	movq	-0x38(%rbp), %rcx
               	leaq	-0x48(%rbp), %rax
               	movq	%rcx, (%rax)
               	sarq	$0x3f, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x80(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rcx
               	leaq	-0x70(%rbp), %rcx
               	movq	-0x38(%rbp), %rsi
               	incq	%rsi
               	movq	%rsi, (%rcx)
               	movq	-0x38(%rbp), %rsi
               	addq	$0x2, %rsi
               	movq	%rsi, 0x8(%rcx)
               	leaq	-0x60(%rbp), %rsi
               	movq	-0x38(%rbp), %r8
               	addq	$0x3, %r8
               	movq	%r8, (%rax)
               	sarq	$0x3f, %r8
               	movq	%r8, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	movq	%rdx, %rax
               	andq	$0xf, %rax
               	andq	$0xf, %rcx
               	orq	%rcx, %rax
               	movq	%rsi, %rcx
               	andq	$0xf, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	orq	$0x4, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	%rdi, %rax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x70(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	movq	%rdi, %rax
               	shlq	%rax
               	addq	$0x3, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x60(%rbp), %rax
               	movq	(%rax), %rcx
               	leaq	0x3(%rdi), %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	orq	$0x8, %rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>

<walk>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	-0x18(%rbp), %rcx
               	imulq	$0x55555556, %rbx, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	leaq	(%rax,%rax,2), %rax
               	movq	%rax, %r10
               	movq	%rbx, %rax
               	subq	%r10, %rax
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
               	movq	%rax, %r10
               	movq	%rbx, %rax
               	subq	%r10, %rax
               	shlq	$0x3, %rax
               	addq	%rcx, %rax
               	movq	(%rax), %rax
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
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
