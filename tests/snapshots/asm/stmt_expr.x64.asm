
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
               	movq	%rcx, %rax
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
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	incq	%rax
               	movl	%eax, (%rcx)
               	movq	%rax, %rdx
               	imulq	$0xa, %rdx, %rdx
               	incq	%rax
               	movl	%eax, (%rcx)
               	imulq	$0x64, %rax, %rax
               	cmpl	$0xa, %edx
               	jne	<addr>
               	cmpl	$0xc8, %eax
               	jne	<addr>
               	movslq	(%rcx), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	movl	%eax, (%rcx)
               	movq	%rax, %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	incq	%rdx
               	movl	%edx, (%rcx)
               	movq	%rdx, %rsi
               	incq	%rdx
               	movl	%edx, (%rcx)
               	movq	%rdx, %rcx
               	addq	%rsi, %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	cmpl	$0x3, %edx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	%eax, (%rcx)
               	movq	%rax, %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	incq	%rdx
               	movl	%edx, (%rcx)
               	movq	%rdx, %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	retq
