
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
               	cmpq	$0x0, (%rdx)
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpq	$0x0, 0x8(%rcx)
               	jne	<addr>
               	cmpq	$0x0, 0x10(%rcx)
               	jne	<addr>
               	cmpq	$0x0, 0x18(%rcx)
               	jne	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x5, %rcx
               	jne	<addr>
               	movq	0x28(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	cmpl	$0x3, %eax
               	jge	<addr>
               	leaq	0x4(%rcx), %rsi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rsi
               	movslq	(%rsi), %rsi
               	cmpl	$0x7, %esi
               	jne	<addr>
               	leaq	0x4(%rcx), %rsi
               	addq	%rsi, %rdx
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
               	xorl	%eax, %eax
               	retq
               	movl	$0x3, %eax
               	retq
