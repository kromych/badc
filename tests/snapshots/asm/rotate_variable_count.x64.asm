
rotate_variable_count.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x40(%rbp), %rax
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
               	xorq	%r9, %r9
               	jmp	<addr>
               	movl	$0x1, %eax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rax
               	movl	%r9d, %ecx
               	movq	(%rax,%rcx,8), %rsi
               	movslq	-0x10(%rbp), %rdx
               	movq	%rsi, %rbx
               	pushq	%rcx
               	movq	%rdx, %rcx
               	rorq	%cl, %rbx
               	popq	%rcx
               	movslq	-0x10(%rbp), %rdi
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movl	$0x1, %edx
               	movslq	%eax, %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	andq	%rsi, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rax, %rdx
               	subq	%rdi, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x1, %r8d
               	movslq	%edx, %rdx
               	movq	%rdx, %r10
               	movq	%r8, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	orq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpq	%rcx, %rbx
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	movl	%r9d, %eax
               	leaq	0x1(%rax), %r9
               	movl	%r9d, %eax
               	cmpl	$0x6, %eax
               	jb	<addr>
               	movabsq	$0x123456789abcdef, %rdi # imm = 0x123456789ABCDEF
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	shrq	$0x7, %rax
               	movq	-0x8(%rbp), %rcx
               	shlq	$0x39, %rcx
               	movq	%rax, %r8
               	orq	%rcx, %r8
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movl	$0x1, %edx
               	movslq	%eax, %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	-0x7(%rax), %rsi
               	andq	$0x3f, %rsi
               	movslq	%esi, %rsi
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	orq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpq	%rcx, %r8
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
