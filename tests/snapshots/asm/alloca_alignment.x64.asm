
alloca_alignment.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sink>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	movq	%rdi, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2060, %rsp           # imm = 0x2060
               	movq	%r13, (%rsp)
               	leaq	-0x30(%rbp), %r10
               	movq	%r10, (%r10)
               	movl	$0x1, %eax
               	movq	%rax, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	leaq	-0x30(%rbp), %r13
               	movq	(%r13), %rax
               	subq	%r10, %rax
               	movq	%rax, (%r13)
               	movq	%rax, -0x8(%rbp)
               	movl	$0x7, %eax
               	movq	%rax, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	leaq	-0x30(%rbp), %r13
               	movq	(%r13), %rax
               	subq	%r10, %rax
               	movq	%rax, (%r13)
               	movq	%rax, -0x10(%rbp)
               	movl	$0x21, %eax
               	movq	%rax, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	leaq	-0x30(%rbp), %r13
               	movq	(%r13), %rax
               	subq	%r10, %rax
               	movq	%rax, (%r13)
               	movq	%rax, -0x18(%rbp)
               	movl	$0x64, %eax
               	movq	%rax, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	leaq	-0x30(%rbp), %r13
               	movq	(%r13), %rax
               	subq	%r10, %rax
               	movq	%rax, (%r13)
               	movq	%rax, -0x20(%rbp)
               	movq	-0x8(%rbp), %rax
               	andq	$0xf, %rax
               	movq	-0x10(%rbp), %rcx
               	andq	$0xf, %rcx
               	orq	%rcx, %rax
               	movq	-0x18(%rbp), %rcx
               	andq	$0xf, %rcx
               	orq	%rcx, %rax
               	movq	-0x20(%rbp), %rcx
               	andq	$0xf, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x2060, %rsp           # imm = 0x2060
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	$0xb, %edx
               	movb	%dl, (%rax)
               	movq	-0x10(%rbp), %rax
               	movl	$0x16, %edx
               	movb	%dl, 0x6(%rax)
               	movq	-0x18(%rbp), %rax
               	movl	$0x21, %edx
               	movb	%dl, 0x20(%rax)
               	movq	-0x20(%rbp), %rax
               	movl	$0x2c, %edx
               	movb	%dl, 0x63(%rax)
               	movq	-0x8(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0xb, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rcx, -0x2048(%rbp)
               	testq	%rax, %rax
               	je	<addr>
               	movq	-0x10(%rbp), %rax
               	movsbq	0x6(%rax), %rax
               	cmpq	$0x16, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x2048(%rbp)
               	movq	-0x2048(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, -0x2040(%rbp)
               	testq	%rax, %rax
               	je	<addr>
               	movq	-0x18(%rbp), %rax
               	movsbq	0x20(%rax), %rax
               	cmpq	$0x21, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x2040(%rbp)
               	movq	-0x2040(%rbp), %rax
               	movq	%rax, -0x2038(%rbp)
               	testq	%rax, %rax
               	je	<addr>
               	movq	-0x20(%rbp), %rax
               	movsbq	0x63(%rax), %rax
               	cmpq	$0x2c, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x2038(%rbp)
               	movq	-0x2038(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x2050(%rbp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rax, -0x2050(%rbp)
               	movq	-0x2050(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x2060, %rsp           # imm = 0x2060
               	popq	%rbp
               	retq
