
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
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdx
               	movslq	(%rdx), %rsi
               	incq	%rsi
               	movl	%esi, (%rdx)
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	movslq	0x4(%rsi), %r8
               	addq	$0xa, %r8
               	movl	%r8d, 0x4(%rsi)
               	movq	(%rdi), %rax
               	movslq	(%rax), %rax
               	addq	%rcx, %rax
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
