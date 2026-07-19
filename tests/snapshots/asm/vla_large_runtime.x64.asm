
vla_large_runtime.x64:	file format elf64-x86-64

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
               	movl	$0x1, %eax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	shlq	$0x12, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	shlq	$0x2, %rax
               	movq	%rax, -0x20(%rbp)
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	movq	%rax, %rsp
               	movq	%rax, -0x18(%rbp)
               	xorq	%rax, %rax
               	movq	%rax, -0x28(%rbp)
               	jmp	<addr>
               	movq	-0x18(%rbp), %rax
               	movq	-0x28(%rbp), %rcx
               	movl	$0x1, %edx
               	movl	%edx, (%rax,%rcx,4)
               	movq	-0x28(%rbp), %rax
               	incq	%rax
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	movq	-0x10(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x38(%rbp)
               	jmp	<addr>
               	movq	-0x30(%rbp), %rdx
               	movq	-0x18(%rbp), %rax
               	movq	-0x38(%rbp), %rcx
               	movslq	(%rax,%rcx,4), %rax
               	addq	%rdx, %rax
               	movq	%rax, -0x30(%rbp)
               	movq	-0x38(%rbp), %rax
               	incq	%rax
               	movq	%rax, -0x38(%rbp)
               	movq	-0x38(%rbp), %rax
               	movq	-0x10(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jl	<addr>
               	movq	-0x30(%rbp), %rax
               	movq	-0x10(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x2a, %eax
               	movq	%rax, -0x48(%rbp)
               	movq	-0x48(%rbp), %rax
               	movslq	%eax, %rax
               	leaq	-0x50(%rbp), %rsp
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
