
three_dim_array_indexing.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sum_row>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	movzbq	(%rdi), %rax
               	movzbq	0x1(%rdi), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movzbq	0x2(%rdi), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movzbq	0x3(%rdi), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rcx
               	movzbq	0x1(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movzbq	0x2(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movzbq	0x3(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	addq	$0x8, %rcx
               	movzbq	(%rcx), %rdx
               	movzbq	0x1(%rcx), %rsi
               	addq	%rsi, %rdx
               	movslq	%edx, %rdx
               	movzbq	0x2(%rcx), %rsi
               	addq	%rsi, %rdx
               	movslq	%edx, %rdx
               	movzbq	0x3(%rcx), %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0x2a, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	addq	$0x10, %rcx
               	movzbq	(%rcx), %rdx
               	movzbq	0x1(%rcx), %rsi
               	addq	%rsi, %rdx
               	movslq	%edx, %rdx
               	movzbq	0x2(%rcx), %rsi
               	addq	%rsi, %rdx
               	movslq	%edx, %rdx
               	movzbq	0x3(%rcx), %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0x4a, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%rax), %rcx
               	xorq	$0x1, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movzbq	0xb(%rax), %rcx
               	xorq	$0xc, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movzbq	0x17(%rax), %rcx
               	xorq	$0x18, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movzbq	0xc(%rax), %rcx
               	movzbq	(%rax), %rdx
               	subq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0xc, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movzbq	0x4(%rax), %rcx
               	movzbq	(%rax), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
