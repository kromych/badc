
local_array_runtime_nested_init.x64:	file format elf64-x86-64

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
               	subq	$0x100, %rsp            # imm = 0x100
               	movl	$0x5, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	$0x6, %eax
               	movl	%eax, -0x10(%rbp)
               	movl	$0x7, %eax
               	movl	%eax, -0x18(%rbp)
               	movl	$0x8, %eax
               	movl	%eax, -0x20(%rbp)
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
               	popq	%rdx
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	movq	%rax, 0x8(%rcx)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	movq	%rax, 0x10(%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	movq	%rax, 0x18(%rcx)
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %edx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x6, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	movq	0x10(%rax), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	movq	0x18(%rax), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x8, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %rax
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
               	popq	%rdx
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x60(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x60(%rbp), %rcx
               	movq	%rax, 0x8(%rcx)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x60(%rbp), %rcx
               	movq	%rax, 0x10(%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x60(%rbp), %rcx
               	movq	%rax, 0x18(%rcx)
               	leaq	-0x60(%rbp), %rax
               	movq	0x10(%rax), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x60(%rbp), %rax
               	movq	0x18(%rax), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x8, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x90(%rbp), %rax
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
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	movq	%rax, (%rcx)
               	xorq	%rax, %rax
               	leaq	-0x90(%rbp), %rcx
               	movq	%rax, 0x18(%rcx)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	movq	%rax, 0x20(%rcx)
               	leaq	-0x90(%rbp), %rax
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %edx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x90(%rbp), %rax
               	movq	0x10(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x90(%rbp), %rax
               	movq	0x20(%rax), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x6, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x90(%rbp), %rax
               	movq	0x28(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0xb0(%rbp), %rax
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
               	popq	%rdx
               	leaq	-0x8(%rbp), %rax
               	leaq	-0xb0(%rbp), %rcx
               	movq	%rax, (%rcx)
               	xorq	%rax, %rax
               	leaq	-0xb0(%rbp), %rcx
               	movq	%rax, 0x8(%rcx)
               	leaq	-0xb0(%rbp), %rcx
               	movq	%rax, 0x10(%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0xb0(%rbp), %rcx
               	movq	%rax, 0x18(%rcx)
               	leaq	-0xb0(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	-0x8(%rbp), %rcx
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %edx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rax
               	movq	0x18(%rax), %rax
               	leaq	-0x20(%rbp), %rcx
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rax
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
