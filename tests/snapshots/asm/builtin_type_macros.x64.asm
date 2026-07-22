
builtin_type_macros.x64:	file format elf64-x86-64

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
               	subq	$0xb0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x1, %edx
               	leaq	-0x40(%rbp), %rax
               	movq	%rdx, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x8(%rax)
               	shlq	$0x24, %rdx
               	leaq	-0x50(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	0x3(%rcx), %rsi
               	cmpq	%rcx, %rsi
               	setb	%al
               	movzbq	%al, %rax
               	addq	$0x0, %rdx
               	addq	%rax, %rdx
               	leaq	-0x60(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x30(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x30(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movq	%rax, %rdx
               	shrq	$0x24, %rdx
               	leaq	-0x70(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	cmpq	$0x1, %rdx
               	je	<addr>
               	movl	$0x15, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rbx
               	movl	$0x5, %ecx
               	xorq	%rdx, %rdx
               	movq	%rax, %rsi
               	imulq	%rcx, %rsi
               	movl	%eax, %edi
               	movq	%rax, %r8
               	shrq	$0x20, %r8
               	movq	%rdi, %r9
               	imulq	%rcx, %r9
               	shrq	$0x20, %r9
               	movq	%r8, %r12
               	imulq	%rcx, %r12
               	addq	%r12, %r9
               	movl	%r9d, %r12d
               	shrq	$0x20, %r9
               	imulq	%rdx, %rdi
               	addq	%r12, %rdi
               	shrq	$0x20, %rdi
               	imulq	%rdx, %r8
               	addq	%r9, %r8
               	addq	%r8, %rdi
               	imulq	%rdx, %rax
               	imulq	%rbx, %rcx
               	addq	%rdi, %rax
               	addq	%rax, %rcx
               	leaq	-0x80(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	cmpq	$0xf, %rsi
               	setb	%al
               	movzbq	%al, %rax
               	leaq	-0xf(%rsi), %rdx
               	subq	$0x0, %rcx
               	subq	%rax, %rcx
               	leaq	-0x90(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x16, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rdx
               	movl	$0x1, %esi
               	leaq	-0xa0(%rbp), %rax
               	movq	%rsi, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x8(%rax)
               	cmpq	%rdx, %rcx
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%rdx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	%rdi, %rsi
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x17, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
