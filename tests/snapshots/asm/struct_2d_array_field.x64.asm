
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
               	addq	$0x0, %rdx
               	imulq	$0xa, %rax, %rsi
               	addq	$0x0, %rsi
               	movl	%esi, (%rdx)
               	leaq	-0x30(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rdx
               	imulq	$0xa, %rax, %rsi
               	incq	%rsi
               	movl	%esi, 0x4(%rdx)
               	leaq	-0x30(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rdx
               	imulq	$0xa, %rax, %rsi
               	addq	$0x2, %rsi
               	movl	%esi, 0x8(%rdx)
               	leaq	-0x30(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rdx
               	imulq	$0xa, %rax, %rsi
               	addq	$0x3, %rsi
               	movl	%esi, 0xc(%rdx)
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jl	<addr>
               	leaq	-0x30(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movq	%rsi, %rdi
               	shlq	$0x4, %rdi
               	addq	%rax, %rdi
               	addq	$0x0, %rdi
               	movslq	(%rdi), %rdi
               	addq	%rdi, %rdx
               	movq	%rsi, %rdi
               	shlq	$0x4, %rdi
               	addq	%rax, %rdi
               	movslq	0x4(%rdi), %rdi
               	addq	%rdi, %rdx
               	movq	%rsi, %rdi
               	shlq	$0x4, %rdi
               	addq	%rax, %rdi
               	movslq	0x8(%rdi), %rdi
               	addq	%rdi, %rdx
               	movq	%rsi, %rdi
               	shlq	$0x4, %rdi
               	addq	%rax, %rdi
               	movslq	0xc(%rdi), %rdi
               	addq	%rdi, %rdx
               	leaq	0x1(%rsi), %rcx
               	movslq	%ecx, %rsi
               	cmpq	$0x3, %rsi
               	jl	<addr>
               	leaq	-0x6f(%rdx), %rax
               	movslq	%eax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
