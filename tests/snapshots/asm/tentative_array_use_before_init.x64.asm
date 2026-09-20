
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
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movslq	%eax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdx, %rsi
               	cmpq	$0x0, (%rsi)
               	je	<addr>
               	incq	%rcx
               	incq	%rax
               	movslq	%eax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdx, %rsi
               	cmpq	$0x0, (%rsi)
               	jne	<addr>
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rcx
               	cmpl	$0xa, %ecx
               	jne	<addr>
               	movslq	0x28(%rax), %rax
               	cmpl	$0x1e, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x8(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0xc(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorl	%eax, %eax
               	retq
