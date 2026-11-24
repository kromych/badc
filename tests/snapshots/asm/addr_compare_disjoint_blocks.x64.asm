
addr_compare_disjoint_blocks.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x28, %rsp
               	movl	<rip>, %eax # <addr>
               	movl	%eax, 0x8(%rsp)
               	leaq	0x8(%rsp), %rdx
               	leaq	0x18(%rsp), %rsi
               	cmpq	%rdx, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	leaq	(%rax,%rax,2), %rax
               	movb	%al, <rip> # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	leaq	0x1(%rcx), %rdi
               	cmpq	%rsi, %rdx
               	cmoveq	%rdi, %rcx
               	leaq	0x1(%rcx), %rdi
               	cmpq	%rsi, %rdx
               	cmoveq	%rdi, %rcx
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x4, %eax
               	jl	<addr>
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x4, %eax
               	movl	%eax, 0x8(%rsp)
               	leaq	0x10(%rsp), %rcx
               	leaq	0x8(%rcx), %rdx
               	leaq	0x8(%rsp), %rcx
               	cmpq	%rcx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%edx, %edx
               	movb	%dl, 0x8(%rsp)
               	leaq	0x18(%rsp), %rsi
               	cmpq	%rcx, %rsi
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	addq	$0x28, %rsp
               	retq
               	movq	%rdx, %rax
               	addq	$0x28, %rsp
               	retq
