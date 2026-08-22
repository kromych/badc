
inline_two_word_struct_return.x64:	file format elf64-x86-64

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
               	subq	$0xb0, %rsp
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x90(%rbp), %rdx
               	movq	%rcx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdx, %rsi
               	imulq	$0xa, %rcx, %rdx
               	leaq	-0xa0(%rbp), %rdi
               	movl	%edx, (%rdi)
               	leaq	-0xa0(%rbp), %rdx
               	movl	$0x1, %edi
               	movq	%rdi, 0x8(%rdx)
               	leaq	-0xa0(%rbp), %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0x90(%rbp), %rax
               	addq	$0x0, %rax
               	movslq	(%rax), %rcx
               	leaq	-0x90(%rbp), %rax
               	addq	$0x0, %rax
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	leaq	(%rax), %rcx
               	leaq	-0x90(%rbp), %rax
               	movslq	0x10(%rax), %rdx
               	leaq	-0x90(%rbp), %rax
               	addq	$0x10, %rax
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	leaq	-0x90(%rbp), %rax
               	movslq	0x20(%rax), %rdx
               	leaq	-0x90(%rbp), %rax
               	addq	$0x20, %rax
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	leaq	-0x90(%rbp), %rax
               	movslq	0x30(%rax), %rdx
               	leaq	-0x90(%rbp), %rax
               	addq	$0x30, %rax
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	leaq	-0x90(%rbp), %rax
               	movslq	0x40(%rax), %rdx
               	leaq	-0x90(%rbp), %rax
               	addq	$0x40, %rax
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	leaq	-0x90(%rbp), %rax
               	movslq	0x50(%rax), %rdx
               	leaq	-0x90(%rbp), %rax
               	addq	$0x50, %rax
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	leaq	-0x90(%rbp), %rax
               	movslq	0x60(%rax), %rdx
               	leaq	-0x90(%rbp), %rax
               	addq	$0x60, %rax
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	leaq	-0x90(%rbp), %rax
               	movslq	0x70(%rax), %rdx
               	leaq	-0x90(%rbp), %rax
               	addq	$0x70, %rax
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	$0x16665, %rax          # imm = 0x16665
               	cmpq	$0x16785, %rax          # imm = 0x16785
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
