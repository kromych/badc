
addr_compare_disjoint_blocks.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rdx
               	leaq	-0x8(%rbp), %rsi
               	leaq	<rip>, %rcx
               	cmpq	%rdx, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	leaq	(%rax,%rax,2), %rax
               	movb	%al, (%rcx)
               	movsbq	%al, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	incq	%rax
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x4, %eax
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	leaq	0x8(%rcx), %rdx
               	leaq	-0x18(%rbp), %rcx
               	cmpq	%rcx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%edx, %edx
               	movb	%dl, -0x18(%rbp)
               	leaq	-0x8(%rbp), %rsi
               	cmpq	%rcx, %rsi
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	leave
               	retq
               	movq	%rdx, %rax
               	leave
               	retq
