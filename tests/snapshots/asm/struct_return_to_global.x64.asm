
struct_return_to_global.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	xorq	%rax, %rax
               	leaq	<rip>, %r8
               	movl	$0x6, %ecx
               	leaq	-0x10(%rbp), %rdx
               	movq	%rcx, (%rdx)
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x1, %edx
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%r8)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%r8)
               	popq	%rax
               	movq	%r8, %rcx
               	movq	(%r8), %rcx
               	movq	0x8(%r8), %rdx
               	addq	%rdx, %rcx
               	leaq	(%rcx), %r9
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	%rcx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdx, %rsi
               	imulq	$0xa, %rcx, %rdx
               	movslq	%edx, %rdx
               	leaq	-0x20(%rbp), %rdi
               	movq	%rdx, (%rdi)
               	leaq	-0x20(%rbp), %rdx
               	movl	$0x1, %edi
               	movq	%rdi, 0x8(%rdx)
               	leaq	-0x20(%rbp), %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	leaq	(%r9,%rax), %rcx
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	leaq	<rip>, %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	leaq	<rip>, %rax
               	addq	$0x30, %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	leaq	-0x30(%rbp), %rax
               	movl	$0x3, %edx
               	movq	%rdx, (%rax)
               	leaq	-0x30(%rbp), %rax
               	movl	$0x4, %edx
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x30(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r8)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r8)
               	popq	%rcx
               	movq	%r8, %rax
               	movq	(%r8), %rax
               	movq	0x8(%r8), %rdx
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	cmpq	$0x4e, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
