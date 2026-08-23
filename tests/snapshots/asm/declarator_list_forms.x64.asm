
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
               	movl	$0x1, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	movl	$0x2, %edx
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rsi)
               	movl	%edx, (%rcx)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x3, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	(%rsi), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rsi
               	movslq	0x8(%rcx), %rcx
               	addq	%rsi, %rcx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rsi
               	addq	%rsi, %rcx
               	cmpl	$0x8, %ecx
               	je	<addr>
               	movq	%rdx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0x3, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpl	$0x4, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	movslq	0xc(%rcx), %rcx
               	addq	%rdx, %rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	cmpl	$0xa, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x61, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movsbq	0x1(%rcx), %rcx
               	cmpl	$0x64, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x7, %ecx
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
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
