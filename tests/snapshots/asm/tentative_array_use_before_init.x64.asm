
tentative_array_use_before_init.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movslq	%eax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rsi, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rcx
               	incq	%rax
               	movslq	%eax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rsi, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0xa, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x28(%rax), %rax
               	cmpl	$0x1e, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movslq	(%rax), %rax
               	addq	$0x0, %rax
               	leaq	<rip>, %rcx
               	movslq	0x4(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movslq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movslq	0xc(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	retq
