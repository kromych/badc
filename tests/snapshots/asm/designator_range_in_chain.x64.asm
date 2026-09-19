
designator_range_in_chain.x64:	file format elf64-x86-64

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

<main>:
               	leaq	<rip>, %rax
               	leaq	0x8(%rax), %rcx
               	leaq	(%rcx), %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	0x8(%rcx), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	0x10(%rcx), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	0x18(%rcx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x5, %rcx
               	jne	<addr>
               	movq	0x28(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorq	%rax, %rax
               	leaq	<rip>, %rcx
               	cmpl	$0x3, %eax
               	jge	<addr>
               	leaq	0x4(%rcx), %rdi
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdi
               	movslq	(%rdi), %rdi
               	cmpl	$0x7, %edi
               	jne	<addr>
               	leaq	0x4(%rcx), %rdi
               	leaq	(%rdi,%rsi), %rdx
               	movslq	0x4(%rdx), %rdx
               	cmpl	$0x8, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x1c(%rax), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	movl	$0x3, %eax
               	retq
