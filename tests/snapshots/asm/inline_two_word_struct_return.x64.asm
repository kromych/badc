
inline_two_word_struct_return.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<mkint>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movl	%edi, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x1, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<mkpair>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movq	%rdi, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rax
               	imulq	$0xa, %rdx, %rdx
               	leaq	-0xe8(%rbp), %rsi
               	movl	%edx, (%rsi)
               	leaq	-0xe8(%rbp), %rdx
               	movl	$0x1, %esi
               	movq	%rsi, 0x8(%rdx)
               	leaq	-0xe8(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jl	<addr>
               	leaq	-0x80(%rbp), %rax
               	addq	$0x0, %rax
               	movslq	(%rax), %rax
               	leaq	-0x80(%rbp), %rcx
               	addq	$0x0, %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	addq	$0x0, %rax
               	leaq	-0x80(%rbp), %rcx
               	movslq	0x10(%rcx), %rcx
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x10, %rdx
               	movq	0x8(%rdx), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	leaq	-0x80(%rbp), %rcx
               	movslq	0x20(%rcx), %rcx
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x20, %rdx
               	movq	0x8(%rdx), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	leaq	-0x80(%rbp), %rcx
               	movslq	0x30(%rcx), %rcx
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x30, %rdx
               	movq	0x8(%rdx), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	leaq	-0x80(%rbp), %rcx
               	movslq	0x40(%rcx), %rcx
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x40, %rdx
               	movq	0x8(%rdx), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	leaq	-0x80(%rbp), %rcx
               	movslq	0x50(%rcx), %rcx
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x50, %rdx
               	movq	0x8(%rdx), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	leaq	-0x80(%rbp), %rcx
               	movslq	0x60(%rcx), %rcx
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x60, %rdx
               	movq	0x8(%rdx), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	leaq	-0x80(%rbp), %rcx
               	movslq	0x70(%rcx), %rcx
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x70, %rdx
               	movq	0x8(%rdx), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movl	$0xaaaa, %ecx           # imm = 0xAAAA
               	movl	$0xbbbb, %edx           # imm = 0xBBBB
               	leaq	-0xf8(%rbp), %rsi
               	movq	%rcx, (%rsi)
               	leaq	-0xf8(%rbp), %rcx
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0xf8(%rbp), %rcx
               	leaq	-0xb8(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0xb8(%rbp), %rcx
               	movq	(%rcx), %rcx
               	leaq	-0xb8(%rbp), %rdx
               	movq	0x8(%rdx), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	cmpq	$0x16785, %rax          # imm = 0x16785
               	jne	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
