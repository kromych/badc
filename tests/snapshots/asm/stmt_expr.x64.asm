
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
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	incq	%rdx
               	movl	%edx, (%rax)
               	movq	%rdx, %rsi
               	incq	%rdx
               	movl	%edx, (%rax)
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
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rdx
               	imulq	$0xa, %rdx, %rdx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	imulq	$0x64, %rcx, %rcx
               	cmpl	$0xa, %edx
               	jne	<addr>
               	cmpl	$0xc8, %ecx
               	jne	<addr>
               	movslq	(%rax), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	incq	%rdx
               	movl	%edx, (%rax)
               	movq	%rdx, %rsi
               	incq	%rdx
               	movl	%edx, (%rax)
               	movq	%rdx, %rax
               	addq	%rsi, %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
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
