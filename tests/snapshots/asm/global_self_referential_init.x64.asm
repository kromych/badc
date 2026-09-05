
global_self_referential_init.x64:	file format elf64-x86-64

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

<drop>:
               	imulq	$-0x1, %rdi, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rbx
               	leaq	0x10(%rbx), %rax
               	movq	(%rax), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	0x18(%rbx), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	0x30(%rbx), %rax
               	movq	(%rax), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	0x28(%rbx), %rcx
               	leaq	0x50(%rbx), %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	0x48(%rbx), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	0x28(%rbx), %rax
               	subq	%rbx, %rax
               	addq	%rbx, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	(%rbx), %rax
               	movl	$0x3, %edi
               	callq	*%rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movslq	0x54(%rbx), %rax
               	cmpl	$-0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0x8(%rbx), %eax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	jmp	<addr>
