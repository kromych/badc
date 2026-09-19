
macro_alias_tail_invocation.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	leaq	<rip>, %rax
               	movl	$0xb, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	cmpl	$0x1, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rsi
               	cmpl	$0xb, %esi
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpl	$0x0, (%rcx)
               	je	<addr>
               	movslq	(%rax), %rdi
               	incq	%rdi
               	movl	%edi, (%rax)
               	movl	$0x16, (%rdx)
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movslq	(%rdx), %rax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpl	$0x0, (%rcx)
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x21, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	cmpl	$0x21, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rsi
               	xorl	%edx, %edx
               	movl	%edx, (%rsi)
               	movslq	(%rax), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movslq	(%rcx), %rax
               	cmpl	$0x21, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	%rdx, %rax
               	retq
