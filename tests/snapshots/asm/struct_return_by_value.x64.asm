
struct_return_by_value.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	-0x18(%rbp), %rcx
               	movq	0x20(%rbp), %rax
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	leaq	0x1(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x2, %rax
               	movq	%rax, 0x10(%rcx)
               	movq	0x10(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<sum_big>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax), %rcx
               	leaq	-0x18(%rbp), %rax
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x18(%rbp), %rax
               	movq	0x10(%rax), %rax
               	addq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<small_round>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rax
               	movl	%edi, (%rax)
               	leaq	-0x20(%rbp), %rcx
               	leaq	0x1(%rdi), %rax
               	movl	%eax, 0x4(%rcx)
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rcx
               	movslq	%ecx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<big_round>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x40(%rbp), %rax
               	movq	%rdi, %rsi
               	movq	%rax, %rdi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%rdi, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq

<echo_small>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x110, %rsp            # imm = 0x110
               	movl	$0x7, %eax
               	leaq	-0x90(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x90(%rbp), %rax
               	movl	$0x8, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x90(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x8, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0xb0(%rbp), %rdi
               	movl	$0xa, %esi
               	callq	<addr>
               	leaq	-0xb0(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x28(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0xb, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movq	0x10(%rax), %rax
               	cmpq	$0xc, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	movl	$0x14, %eax
               	leaq	-0xd0(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0xd0(%rbp), %rax
               	movl	$0x15, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0xd0(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0xe8(%rbp), %rdi
               	movl	$0x1e, %esi
               	callq	<addr>
               	leaq	-0xe8(%rbp), %rax
               	movq	0x10(%rax), %rax
               	cmpq	$0x20, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rcx
               	movl	$0x28, %eax
               	leaq	-0xf8(%rbp), %rdx
               	movl	%eax, (%rdx)
               	leaq	-0xf8(%rbp), %rax
               	movl	$0x29, %edx
               	movl	%edx, 0x4(%rax)
               	leaq	-0xf8(%rbp), %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x68(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x28, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x68(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x29, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x12, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x108(%rbp)
               	leaq	-0x108(%rbp), %rax
               	leaq	-0x78(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x8, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
