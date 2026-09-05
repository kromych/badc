
declarator_list_forms.x64:	file format elf64-x86-64

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

<add>:
               	leaq	(%rdi,%rsi), %rax
               	movslq	%eax, %rax
               	retq

<sub>:
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, %ecx
               	movl	%ecx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	movl	$0x2, %edx
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rax
               	movq	%rax, (%rsi)
               	movl	%edx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x3, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	(%rsi), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	movslq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movq	%rdx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x4, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	movslq	0xc(%rax), %rax
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x61, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x64, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	xorq	$0x2, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x8(%rbp), %rax
               	movslq	(%rdi), %rcx
               	addq	%rcx, %rax
               	incq	%rax
               	addq	$0x2, %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x3, %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	$0x2a, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
