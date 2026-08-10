
indirect_struct_return_outptr.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<make_big>:
               	popq	%r10
               	subq	$0x20, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x28(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, 0x20(%rax)
               	movslq	0x20(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rdx
               	leaq	-0x28(%rbp), %rcx
               	movq	%rdx, 0x8(%rcx)
               	addq	$0x2, %rax
               	movslq	%eax, %rcx
               	leaq	-0x28(%rbp), %rax
               	movq	%rcx, 0x10(%rax)
               	movslq	0x20(%rbp), %rax
               	addq	$0x3, %rax
               	movslq	%eax, %rcx
               	leaq	-0x28(%rbp), %rax
               	movq	%rcx, 0x18(%rax)
               	movslq	0x20(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	%eax, %rcx
               	leaq	-0x28(%rbp), %rax
               	movq	%rcx, 0x20(%rax)
               	movq	0x10(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
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
               	popq	%rdx
               	movq	%rax, %rcx
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<make_pair>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	leaq	-0x10(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rdi, (%rax)
               	movq	%rdi, %rax
               	shlq	%rax
               	movslq	%eax, %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	-<rip>, %r12      # <addr>
               	leaq	-<rip>, %rbx       # <addr>
               	movl	$0xa, %esi
               	leaq	-0x80(%rbp), %rdi
               	movq	%r12, %rax
               	callq	*%rax
               	leaq	-0x80(%rbp), %rax
               	leaq	-0xa8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	movq	0x18(%rax), %rdx
               	movq	%rdx, 0x18(%rcx)
               	movq	0x20(%rax), %rdx
               	movq	%rdx, 0x20(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xa8(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0xa8(%rbp), %rax
               	movq	0x10(%rax), %rax
               	cmpq	$0xc, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa8(%rbp), %rax
               	movq	0x20(%rax), %rax
               	cmpq	$0xe, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %edi
               	movq	%rbx, %rax
               	callq	*%rax
               	movq	%rax, -0x58(%rbp)
               	movq	%rdx, -0x50(%rbp)
               	leaq	-0x58(%rbp), %rax
               	leaq	-0xb8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xb8(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xb8(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0xe, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %esi
               	leaq	-0x48(%rbp), %rdi
               	movq	%r12, %rax
               	callq	*%rax
               	leaq	-0x48(%rbp), %rax
               	movq	0x20(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %r12d
               	movq	%rbx, %rax
               	movq	%r12, %rdi
               	callq	*%rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %r13
               	movq	%rbx, %rax
               	movq	%r12, %rdi
               	callq	*%rax
               	movq	%rax, -0x20(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	0x8(%rax), %rax
               	addq	%r13, %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
