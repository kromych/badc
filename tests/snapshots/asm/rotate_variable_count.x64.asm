
rotate_variable_count.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<rotr_var>:
               	movslq	%esi, %rsi
               	movq	%rdi, %rax
               	pushq	%rcx
               	movq	%rsi, %rcx
               	rorq	%cl, %rax
               	popq	%rcx
               	retq

<ref_ror>:
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movl	$0x1, %r8d
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shlq	%cl, %r8
               	popq	%rcx
               	andq	%rdi, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movq	%rcx, %r8
               	subq	%rsi, %r8
               	andq	$0x3f, %r8
               	movl	$0x1, %r9d
               	movslq	%r8d, %r8
               	movq	%r8, %r10
               	movq	%r9, %r8
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r8
               	popq	%rcx
               	orq	%r8, %rax
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x40, %rdx
               	jl	<addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
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
               	movq	(%rax,%rcx,8), %rax
               	movslq	-0x40(%rbp), %rcx
               	movq	%rax, %r12
               	rorq	%cl, %r12
               	leaq	-0x30(%rbp), %rax
               	movl	%ebx, %ecx
               	movq	(%rax,%rcx,8), %rdi
               	movslq	-0x40(%rbp), %rsi
               	callq	<addr>
               	cmpq	%rax, %r12
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
               	movq	%rax, %rbx
               	orq	%rcx, %rbx
               	movl	$0x7, %esi
               	callq	<addr>
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
