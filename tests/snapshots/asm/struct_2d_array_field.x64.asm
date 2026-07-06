
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
               	leaq	-0x30(%rbp), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rax
               	addq	$0x0, %rax
               	imulq	$0xa, %rdx, %rdx
               	addq	$0x0, %rdx
               	movl	%edx, (%rax)
               	leaq	-0x30(%rbp), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rax
               	imulq	$0xa, %rdx, %rdx
               	incq	%rdx
               	movl	%edx, 0x4(%rax)
               	leaq	-0x30(%rbp), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rax
               	imulq	$0xa, %rdx, %rdx
               	addq	$0x2, %rdx
               	movl	%edx, 0x8(%rax)
               	leaq	-0x30(%rbp), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rax
               	imulq	$0xa, %rdx, %rdx
               	addq	$0x3, %rdx
               	movl	%edx, 0xc(%rax)
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jl	<addr>
               	leaq	-0x30(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rax, %rsi
               	addq	$0x0, %rsi
               	movslq	(%rsi), %rsi
               	addq	%rsi, %rdx
               	movslq	%ecx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rax, %rsi
               	movslq	0x4(%rsi), %rsi
               	addq	%rsi, %rdx
               	movslq	%ecx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rax, %rsi
               	movslq	0x8(%rsi), %rsi
               	addq	%rsi, %rdx
               	movslq	%ecx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rax, %rsi
               	movslq	0xc(%rsi), %rsi
               	addq	%rsi, %rdx
               	movslq	%ecx, %rcx
               	incq	%rcx
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
               	addb	%al, 0x41(%rdx)
