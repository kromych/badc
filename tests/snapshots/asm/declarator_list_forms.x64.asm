
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
               	retq

<sub>:
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	$0x2, %ecx
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movq	%rsi, (%rdx)
               	movl	%ecx, (%rsi)
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rsi
               	cmpl	$0x4, %esi
               	jne	<addr>
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rsi
               	cmpl	$0x3, %esi
               	jne	<addr>
               	movq	(%rdx), %rdx
               	movslq	(%rdx), %rdx
               	cmpl	$0x2, %edx
               	je	<addr>
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	movslq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movq	%rcx, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movslq	0x8(%rax), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
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
               	leave
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
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	xorq	$0x2, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movslq	-0x8(%rbp), %rax
               	addq	%rax, %rax
               	incq	%rax
               	addq	$0x2, %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x3, %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
