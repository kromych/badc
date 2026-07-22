
int128_struct_member.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<bump>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rsi, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	leaq	0x10(%rdi), %rcx
               	movq	(%rcx), %rdx
               	movq	0x18(%rdi), %r8
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rsi
               	cmpq	%rdx, %rsi
               	setb	%dl
               	movzbq	%dl, %rdx
               	addq	%r8, %rax
               	addq	%rax, %rdx
               	leaq	-0x20(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rdx, 0x8(%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movslq	(%rdi), %rax
               	incq	%rax
               	movl	%eax, (%rdi)
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<read_wide>:
               	leaq	0x10(%rdi), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x290, %rsp            # imm = 0x290
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	leaq	-0x100(%rbp), %rax
               	movq	%rdx, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x110(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rcx, %rsi
               	orq	%rax, %rsi
               	orq	%rdx, %rcx
               	leaq	-0x120(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpq	$0x1, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	0x20(%rax), %rcx
               	cmpq	$0x2, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	movq	0x18(%rax), %rdx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x290, %rsp            # imm = 0x290
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x290, %rsp            # imm = 0x290
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rdi
               	movl	$0x1, %edx
               	leaq	-0x148(%rbp), %rax
               	movq	%rdx, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x8(%rax)
               	shlq	$0x24, %rdx
               	leaq	-0x158(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, %rax
               	xorq	%rcx, %rax
               	movq	%rdi, %rcx
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rcx
               	xorq	%rdx, %rdx
               	leaq	-0x168(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x290, %rsp            # imm = 0x290
               	popq	%rbp
               	retq
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
               	leaq	-0x70(%rbp), %rax
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
               	movl	$0x1, %eax
               	leaq	-0x70(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x70(%rbp), %rdx
               	addq	$0x10, %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	movl	$0x2, %edx
               	leaq	-0x70(%rbp), %rcx
               	movl	%edx, 0x20(%rcx)
               	leaq	-0x40(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x1, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	movslq	0x20(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	movq	0x10(%rax), %rcx
               	movq	0x18(%rax), %rdx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x290, %rsp            # imm = 0x290
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x70(%rbp), %rax
               	movslq	0x20(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x70(%rbp), %rax
               	movq	0x10(%rax), %rcx
               	movq	0x18(%rax), %rdx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x290, %rsp            # imm = 0x290
               	popq	%rbp
               	retq
               	leaq	-0xa0(%rbp), %rax
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
               	movl	$0x1, %ecx
               	leaq	-0xa0(%rbp), %rax
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0xa0(%rbp), %rdx
               	addq	$0x10, %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	movl	$0x2, %edx
               	leaq	-0xa0(%rbp), %rax
               	movl	%edx, 0x20(%rax)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x198(%rbp), %rax
               	movq	%rcx, (%rax)
               	xorq	%rdx, %rdx
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x1a8(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rdx, %rax
               	orq	$0x3, %rax
               	orq	%rdx, %rcx
               	leaq	-0x1b8(%rbp), %rsi
               	movq	%rax, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0xa0(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rax
               	movslq	0x20(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x290, %rsp            # imm = 0x290
               	popq	%rbp
               	retq
               	leaq	-0xa0(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x1d0(%rbp)
               	movq	%rdx, -0x1c8(%rbp)
               	leaq	-0x1d0(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %r8
               	movl	$0xa, %edx
               	leaq	-0x1e0(%rbp), %rax
               	movq	%rdx, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x1f0(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rcx, %rsi
               	orq	$0x7, %rsi
               	orq	%rdx, %rcx
               	leaq	-0x200(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rdi, %rax
               	xorq	%rsi, %rax
               	xorq	%r8, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x290, %rsp            # imm = 0x290
               	popq	%rbp
               	retq
               	leaq	-0xa0(%rbp), %rax
               	leaq	0x10(%rax), %rdx
               	xorq	%rax, %rax
               	leaq	-0x210(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0xa0(%rbp), %rcx
               	movq	0x10(%rcx), %rdx
               	movq	0x18(%rcx), %rcx
               	xorq	%rax, %rdx
               	xorq	%rcx, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rax
               	movslq	0x20(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x290, %rsp            # imm = 0x290
               	popq	%rbp
               	retq
               	leaq	-0xa0(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	-0x10(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xa0(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x230(%rbp)
               	movq	%rdx, -0x228(%rbp)
               	leaq	-0x230(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x290, %rsp            # imm = 0x290
               	popq	%rbp
               	retq
               	leaq	-0xf0(%rbp), %rax
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
               	movl	$0x1, %ecx
               	leaq	-0x240(%rbp), %rax
               	movq	%rcx, (%rax)
               	xorq	%rdx, %rdx
               	movq	%rdx, 0x8(%rax)
               	leaq	-0xf0(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x10(%rbp), %rax
               	leaq	-0xf0(%rbp), %rsi
               	addq	$0x10, %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x250(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rcx, %rsi
               	shlq	$0x3f, %rsi
               	leaq	-0x260(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	-0xf0(%rbp), %rsi
               	addq	$0x20, %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0xf0(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xf0(%rbp), %rax
               	movq	0x10(%rax), %rcx
               	movq	0x18(%rax), %rdx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x290, %rsp            # imm = 0x290
               	popq	%rbp
               	retq
               	leaq	-0xf0(%rbp), %rax
               	movq	0x20(%rax), %rsi
               	movq	0x28(%rax), %rdi
               	movl	$0x1, %edx
               	leaq	-0x280(%rbp), %rax
               	movq	%rdx, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x8(%rax)
               	shlq	$0x3f, %rdx
               	leaq	-0x290(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, %rax
               	xorq	%rcx, %rax
               	movq	%rdi, %rcx
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xf0(%rbp), %rax
               	movq	0x20(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x290, %rsp            # imm = 0x290
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x290, %rsp            # imm = 0x290
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
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
