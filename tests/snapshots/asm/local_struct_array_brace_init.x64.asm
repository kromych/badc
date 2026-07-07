
local_struct_array_brace_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sum_lens>:
               	movq	%rsi, %r8
               	movslq	%r8d, %r8
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rcx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdi, %rsi
               	movq	0x8(%rsi), %rsi
               	addq	%rsi, %rdx
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	%r8, %rcx
               	jl	<addr>
               	movq	%rdx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	popq	%rdx
               	leaq	-0x30(%rbp), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movq	0x28(%rax), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	popq	%rdx
               	leaq	-0x40(%rbp), %rax
               	leaq	-0x98(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movl	$0x10, %ecx
               	leaq	-0x98(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x60(%rbp), %rcx
               	leaq	-0x98(%rbp), %rax
               	movq	%rcx, 0x10(%rax)
               	movl	$0x20, %ecx
               	leaq	-0x98(%rbp), %rax
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x98(%rbp), %rax
               	movq	%rcx, 0x20(%rax)
               	movl	$0x8, %ecx
               	leaq	-0x98(%rbp), %rax
               	movq	%rcx, 0x28(%rax)
               	leaq	-0x98(%rbp), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x38, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	-0x40(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	movq	0x10(%rax), %rax
               	leaq	-0x60(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	movq	0x20(%rax), %rax
               	leaq	-0x68(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	movq	0x28(%rax), %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
