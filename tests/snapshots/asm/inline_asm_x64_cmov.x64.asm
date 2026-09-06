
inline_asm_x64_cmov.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	movl	$0x14, %eax
               	movl	$0x2a, %ecx
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rbx, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	-0x28(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x20(%rbp), %rbx
               	cmpq	%rbx, %rax
               	cmovlq	%rbx, %rax
               	movq	-0x28(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x30(%rbp), %rbx
               	movq	-0x8(%rbp), %rdx
               	movl	$0xa, %eax
               	movq	%rcx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rsi
               	movq	%rbx, -0x30(%rbp)
               	movq	%rsi, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	-0x28(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x20(%rbp), %rbx
               	cmpq	%rbx, %rax
               	cmovlq	%rbx, %rax
               	movq	-0x28(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x30(%rbp), %rbx
               	movq	-0x8(%rbp), %rsi
               	movl	$0x64, %eax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rbx, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	-0x28(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x20(%rbp), %rbx
               	cmpq	%rbx, %rax
               	cmovgq	%rbx, %rax
               	movq	-0x28(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x30(%rbp), %rbx
               	movq	-0x8(%rbp), %rdi
               	movl	$0x63, %eax
               	movq	%rcx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rbx, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	-0x28(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x20(%rbp), %rbx
               	cmpq	%rbx, %rax
               	cmovgq	%rbx, %rax
               	movq	-0x28(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x30(%rbp), %rbx
               	movq	-0x8(%rbp), %rcx
               	cmpq	$0x2a, %rdx
               	jne	<addr>
               	cmpq	$0x2a, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x2a, %rdi
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x2a, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2a, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	leave
               	retq
