
stmt_expr.x64:	file format elf64-x86-64

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

<bump>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movslq	%ecx, %rax
               	retq

<main>:
               	leaq	<rip>, %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rsi
               	incq	%rsi
               	movl	%esi, (%rdx)
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rsi
               	incq	%rsi
               	movl	%esi, (%rdx)
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdi
               	incq	%rdi
               	movl	%edi, (%rdx)
               	movq	%rdi, %rdx
               	shlq	%rdx
               	addq	%rsi, %rdx
               	cmpl	$0x8, %edx
               	jne	<addr>
               	movslq	(%rax), %rdx
               	cmpl	$0x3, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	%ecx, (%rax)
               	movq	%rcx, %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movq	%rdx, %rsi
               	imulq	$0xa, %rsi, %rsi
               	incq	%rdx
               	movl	%edx, (%rax)
               	imulq	$0x64, %rdx, %rdx
               	cmpl	$0xa, %esi
               	jne	<addr>
               	cmpl	$0xc8, %edx
               	jne	<addr>
               	movslq	(%rax), %rdx
               	cmpl	$0x2, %edx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	%ecx, (%rax)
               	movq	%rcx, %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	incq	%rdx
               	movl	%edx, (%rax)
               	movq	%rdx, %rsi
               	incq	%rdx
               	movl	%edx, (%rax)
               	addq	%rsi, %rdx
               	cmpl	$0x5, %edx
               	jne	<addr>
               	movslq	(%rax), %rdx
               	cmpl	$0x3, %edx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	%ecx, (%rax)
               	movq	%rcx, %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	incq	%rdx
               	movl	%edx, (%rax)
               	movq	%rdx, %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movq	%rcx, %rax
               	retq
