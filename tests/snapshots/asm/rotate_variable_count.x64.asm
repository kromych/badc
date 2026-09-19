
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
               	subq	$0x48, %rsp
               	pushq	%rbx
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
               	xorl	%r9d, %r9d
               	cmpl	$0x6, %r9d
               	jae	<addr>
               	movl	$0x1, -0x10(%rbp)
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax,%r9,8), %rsi
               	movslq	-0x10(%rbp), %rcx
               	movq	%rsi, %rbx
               	rorq	%cl, %rbx
               	movslq	-0x10(%rbp), %rdi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	cmpl	$0x40, %ecx
               	jge	<addr>
               	movl	$0x1, %edx
               	shlq	%cl, %rdx
               	andq	%rsi, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rcx, %rdx
               	subq	%rdi, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x1, %r8d
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shlq	%cl, %r8
               	popq	%rcx
               	orq	%r8, %rax
               	incq	%rcx
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	cmpq	%rax, %rbx
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	incq	%r9
               	cmpl	$0x6, %r9d
               	jb	<addr>
               	movabsq	$0x123456789abcdef, %rdi # imm = 0x123456789ABCDEF
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	shrq	$0x7, %rax
               	movq	-0x8(%rbp), %rcx
               	shlq	$0x39, %rcx
               	movq	%rax, %r8
               	orq	%rcx, %r8
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	cmpl	$0x40, %ecx
               	jge	<addr>
               	movl	$0x1, %edx
               	movq	%rdx, %rsi
               	shlq	%cl, %rsi
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	-0x7(%rcx), %rsi
               	andq	$0x3f, %rsi
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	orq	%rdx, %rax
               	incq	%rcx
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	cmpq	%rax, %r8
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
