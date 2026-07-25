
inline_asm_x64_catalogue.x64:	file format elf64-x86-64

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
               	subq	$0x90, %rsp
               	movabsq	$-0x14, %rax
               	movq	%rax, -0x68(%rbp)
               	leaq	-0x68(%rbp), %rax
               	movq	%rax, -0x90(%rbp)
               	movq	%rax, -0x88(%rbp)
               	movq	-0x88(%rbp), %r10
               	movq	(%r10), %rax
               	negq	%rax
               	movq	-0x88(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x90(%rbp), %rax
               	movq	-0x68(%rbp), %rdx
               	movabsq	$-0x8, %rax
               	movq	%rax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rax
               	movq	%rax, -0x90(%rbp)
               	movq	%rax, -0x88(%rbp)
               	movq	-0x88(%rbp), %r10
               	movq	(%r10), %rax
               	notq	%rax
               	movq	-0x88(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x90(%rbp), %rax
               	movq	-0x70(%rbp), %rsi
               	movl	$0x64, %eax
               	movq	%rax, -0x18(%rbp)
               	movl	$0xf, %eax
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	%rax, -0x90(%rbp)
               	movq	%rbx, -0x88(%rbp)
               	movq	%rax, -0x80(%rbp)
               	movq	%rcx, -0x78(%rbp)
               	movq	-0x80(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x78(%rbp), %r10
               	movq	(%r10), %rbx
               	xchgq	%rbx, %rax
               	movq	-0x80(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x78(%rbp), %r10
               	movq	%rbx, (%r10)
               	movq	-0x90(%rbp), %rax
               	movq	-0x88(%rbp), %rbx
               	movl	$0x5, %eax
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movq	%rax, -0x90(%rbp)
               	movq	%rax, -0x88(%rbp)
               	movq	-0x88(%rbp), %r10
               	movq	(%r10), %rax
               	rolq	%rax
               	movq	-0x88(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x90(%rbp), %rax
               	movl	$0x14, %eax
               	movq	%rax, -0x30(%rbp)
               	movl	$0x16, %eax
               	leaq	-0x30(%rbp), %rcx
               	movq	%rax, -0x90(%rbp)
               	movq	%rbx, -0x88(%rbp)
               	movq	%rcx, -0x80(%rbp)
               	movq	%rax, -0x78(%rbp)
               	movq	-0x80(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x78(%rbp), %rbx
               	addq	$0x0, %rax
               	adcq	%rbx, %rax
               	movq	-0x80(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x90(%rbp), %rax
               	movq	-0x88(%rbp), %rbx
               	cmpq	$0x14, %rdx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpq	$0x7, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	-0x18(%rbp), %rax
               	cmpq	$0xf, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorq	%rdx, %rdx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	-0x20(%rbp), %rax
               	cmpq	$0x64, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	xorq	%rax, %rax
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	-0x28(%rbp), %rax
               	cmpq	$0xa, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	-0x30(%rbp), %rax
               	cmpq	$0x2a, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2a, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
