
inline_asm_x64_catalogue.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<neg_asm>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, 0x10(%rbp)
               	leaq	0x10(%rbp), %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %r10
               	movq	(%r10), %rax
               	negq	%rax
               	movq	-0x8(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x10(%rbp), %rax
               	movq	0x10(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<not_asm>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, 0x10(%rbp)
               	leaq	0x10(%rbp), %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %r10
               	movq	(%r10), %rax
               	notq	%rax
               	movq	-0x8(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x10(%rbp), %rax
               	movq	0x10(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movabsq	$-0x14, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	movabsq	$-0x8, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x64, %eax
               	movq	%rax, -0x18(%rbp)
               	movl	$0xf, %eax
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x20(%rbp), %rdx
               	movq	%rax, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%rax, -0x70(%rbp)
               	movq	%rdx, -0x68(%rbp)
               	movq	-0x70(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x68(%rbp), %r10
               	movq	(%r10), %rbx
               	xchgq	%rbx, %rax
               	movq	-0x70(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x68(%rbp), %r10
               	movq	%rbx, (%r10)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rbx
               	movl	$0x5, %eax
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movq	%rax, -0x80(%rbp)
               	movq	%rax, -0x78(%rbp)
               	movq	-0x78(%rbp), %r10
               	movq	(%r10), %rax
               	rolq	%rax
               	movq	-0x78(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x80(%rbp), %rax
               	movl	$0x14, %eax
               	movq	%rax, -0x30(%rbp)
               	movl	$0x16, %eax
               	leaq	-0x30(%rbp), %rdx
               	movq	%rax, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%rdx, -0x70(%rbp)
               	movq	%rax, -0x68(%rbp)
               	movq	-0x70(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x68(%rbp), %rbx
               	addq	$0x0, %rax
               	adcq	%rbx, %rax
               	movq	-0x70(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rbx
               	cmpq	$0x14, %rbx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rax, %rax
               	testq	%rdx, %rdx
               	je	<addr>
               	cmpq	$0x7, %rcx
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
               	movq	(%rsp), %rbx
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
