
compound_literal_static_init.x64:	file format elf64-x86-64

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
               	movl	(%rcx), %ecx
               	imulq	$0xa, %rcx, %rcx
               	leaq	<rip>, %rdx
               	movl	(%rdx), %edx
               	addq	%rdx, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	movslq	(%rdx), %rsi
               	incq	%rsi
               	movl	%esi, (%rdx)
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	movslq	0x4(%rdx), %rsi
               	addq	$0xa, %rsi
               	movl	%esi, 0x4(%rdx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	addq	%rcx, %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rcx
               	movslq	(%rcx), %rsi
               	addq	%rsi, %rax
               	movslq	0x4(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	subq	$0x64, %rax
               	movslq	%eax, %rax
               	retq
