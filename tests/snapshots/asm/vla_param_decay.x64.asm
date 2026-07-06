
vla_param_decay.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<dot>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rdi
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movslq	%ecx, %r8
               	shlq	$0x2, %r8
               	leaq	(%rsi,%r8), %r9
               	movslq	(%r9), %r9
               	addq	%rdx, %r8
               	movslq	(%r8), %r8
               	imulq	%r9, %r8
               	addq	%r8, %rax
               	movslq	%ecx, %rcx
               	incq	%rcx
               	movslq	%ecx, %r8
               	cmpq	%rdi, %r8
               	jl	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movl	$0x4, %edi
               	leaq	-0x10(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdx
               	callq	<addr>
               	cmpq	$0x46, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
