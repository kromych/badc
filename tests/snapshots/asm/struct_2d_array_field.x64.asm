
struct_2d_array_field.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rdx
               	leaq	(%rdx), %rsi
               	imulq	$0xa, %rax, %rdx
               	addq	$0x0, %rdx
               	movl	%edx, (%rsi)
               	leaq	-0x30(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdx, %rsi
               	imulq	$0xa, %rax, %rdx
               	incq	%rdx
               	movl	%edx, 0x4(%rsi)
               	leaq	-0x30(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdx, %rsi
               	imulq	$0xa, %rax, %rdx
               	addq	$0x2, %rdx
               	movl	%edx, 0x8(%rsi)
               	leaq	-0x30(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdx, %rsi
               	imulq	$0xa, %rax, %rdx
               	addq	$0x3, %rdx
               	movl	%edx, 0xc(%rsi)
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jl	<addr>
               	leaq	-0x30(%rbp), %rsi
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rdx, %rdi
               	shlq	$0x4, %rdi
               	addq	%rsi, %rdi
               	addq	$0x0, %rdi
               	movslq	(%rdi), %rdi
               	addq	%rdi, %rcx
               	movq	%rdx, %rdi
               	shlq	$0x4, %rdi
               	addq	%rsi, %rdi
               	movslq	0x4(%rdi), %rdi
               	addq	%rdi, %rcx
               	movq	%rdx, %rdi
               	shlq	$0x4, %rdi
               	addq	%rsi, %rdi
               	movslq	0x8(%rdi), %rdi
               	addq	%rdi, %rcx
               	movq	%rdx, %rdi
               	shlq	$0x4, %rdi
               	addq	%rsi, %rdi
               	movslq	0xc(%rdi), %rdi
               	addq	%rdi, %rcx
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x3, %rdx
               	jl	<addr>
               	leaq	-0x6f(%rcx), %rax
               	movslq	%eax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
