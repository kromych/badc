
inline_asm_x64_cmov.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	movl	$0x14, %ecx
               	movl	$0x2a, %eax
               	movq	%rcx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, -0x30(%rbp)
               	movq	%rbx, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	-0x20(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x18(%rbp), %rbx
               	cmpq	%rbx, %rax
               	cmovlq	%rbx, %rax
               	movq	-0x20(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rbx
               	movq	-0x8(%rbp), %rdx
               	movl	$0xa, %ecx
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rsi
               	movq	%rax, -0x30(%rbp)
               	movq	%rbx, -0x28(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movq	-0x20(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x18(%rbp), %rbx
               	cmpq	%rbx, %rax
               	cmovlq	%rbx, %rax
               	movq	-0x20(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rbx
               	movq	-0x8(%rbp), %rsi
               	movl	$0x64, %ecx
               	movq	%rcx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, -0x30(%rbp)
               	movq	%rbx, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	-0x20(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x18(%rbp), %rbx
               	cmpq	%rbx, %rax
               	cmovgq	%rbx, %rax
               	movq	-0x20(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rbx
               	movq	-0x8(%rbp), %rdi
               	movl	$0x63, %ecx
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rbx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movq	-0x20(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x18(%rbp), %rbx
               	cmpq	%rbx, %rax
               	cmovgq	%rbx, %rax
               	movq	-0x20(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rbx
               	movq	-0x8(%rbp), %r8
               	cmpq	$0x2a, %rdx
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x2a, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpq	$0x2a, %rdi
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x2a, %r8
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2a, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
