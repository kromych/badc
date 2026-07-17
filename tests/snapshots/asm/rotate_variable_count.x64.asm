
rotate_variable_count.x64:	file format elf64-x86-64

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
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	popq	%rdx
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	movl	$0x1, %eax
               	movl	%eax, -0x40(%rbp)
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rax
               	movl	%ebx, %ecx
               	movq	(%rax,%rcx,8), %rcx
               	movslq	-0x40(%rbp), %rax
               	movq	%rcx, %r12
               	pushq	%rcx
               	movq	%rax, %rcx
               	rorq	%cl, %r12
               	popq	%rcx
               	leaq	-0x30(%rbp), %rax
               	movl	%ebx, %ecx
               	movq	(%rax,%rcx,8), %r8
               	movslq	-0x40(%rbp), %rdi
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movl	$0x1, %esi
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	andq	%r8, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rax, %rsi
               	subq	%rdi, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x1, %r9d
               	movslq	%esi, %rsi
               	movq	%rsi, %r10
               	movq	%r9, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	orq	%rsi, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x40, %rdx
               	jl	<addr>
               	cmpq	%rcx, %r12
               	jne	<addr>
               	movslq	-0x40(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x40(%rbp)
               	movslq	-0x40(%rbp), %rax
               	cmpq	$0x40, %rax
               	jl	<addr>
               	movl	%ebx, %eax
               	leaq	0x1(%rax), %rbx
               	movl	%ebx, %eax
               	cmpq	$0x6, %rax
               	jb	<addr>
               	movabsq	$0x123456789abcdef, %rdi # imm = 0x123456789ABCDEF
               	movq	%rdi, -0x48(%rbp)
               	movq	-0x48(%rbp), %rax
               	shrq	$0x7, %rax
               	movq	-0x48(%rbp), %rcx
               	shlq	$0x39, %rcx
               	movq	%rax, %r9
               	orq	%rcx, %r9
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movl	$0x1, %esi
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	-0x7(%rax), %rsi
               	andq	$0x3f, %rsi
               	movl	$0x1, %r8d
               	movslq	%esi, %rsi
               	movq	%rsi, %r10
               	movq	%r8, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	orq	%rsi, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x40, %rdx
               	jl	<addr>
               	cmpq	%rcx, %r9
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
