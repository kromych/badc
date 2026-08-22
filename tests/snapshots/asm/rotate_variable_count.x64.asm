
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
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
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
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	movl	$0x1, %eax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rax
               	movl	%ebx, %ecx
               	movq	(%rax,%rcx,8), %rsi
               	movslq	-0x10(%rbp), %rdx
               	movq	%rsi, %r12
               	pushq	%rcx
               	movq	%rdx, %rcx
               	rorq	%cl, %r12
               	popq	%rcx
               	movq	(%rax,%rcx,8), %r8
               	movslq	-0x10(%rbp), %rdi
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movl	$0x1, %edx
               	movslq	%eax, %rsi
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	andq	%r8, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rax, %rdx
               	subq	%rdi, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x1, %r9d
               	movslq	%edx, %rdx
               	movq	%rdx, %r10
               	movq	%r9, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	orq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpq	%rcx, %r12
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	movl	%ebx, %eax
               	leaq	0x1(%rax), %rbx
               	movl	%ebx, %eax
               	cmpl	$0x6, %eax
               	jb	<addr>
               	movabsq	$0x123456789abcdef, %r8 # imm = 0x123456789ABCDEF
               	movq	%r8, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	shrq	$0x7, %rax
               	movq	-0x8(%rbp), %rcx
               	shlq	$0x39, %rcx
               	movq	%rax, %r9
               	orq	%rcx, %r9
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movl	$0x1, %esi
               	movslq	%eax, %rdi
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	andq	%r8, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	-0x7(%rax), %rdx
               	andq	$0x3f, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	orq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpq	%rcx, %r9
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
