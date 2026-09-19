
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
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0xb, %edx
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rsi
               	incq	%rsi
               	movl	%esi, (%rcx)
               	leaq	<rip>, %rcx
               	movl	%edx, (%rcx)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0xb, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x16, %edx
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rsi
               	incq	%rsi
               	movl	%esi, (%rcx)
               	leaq	<rip>, %rcx
               	movl	%edx, (%rcx)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x16, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x21, %edx
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rsi
               	incq	%rsi
               	movl	%esi, (%rcx)
               	leaq	<rip>, %rcx
               	movl	%edx, (%rcx)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x21, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x21, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	%rcx, %rax
               	retq
