
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
               	movl	%ecx, %ecx
               	leaq	<rip>, %rdx
               	movl	(%rdx), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, %esi
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rcx
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	movslq	0x4(%rdx), %r8
               	addq	$0xa, %r8
               	movl	%r8d, 0x4(%rdx)
               	xorq	%rax, %rax
               	movq	(%rdi), %rax
               	movslq	(%rax), %rax
               	addq	%rsi, %rax
               	movq	(%rcx), %rdx
               	movslq	(%rdx), %rsi
               	addq	%rsi, %rax
               	movslq	0x4(%rdx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	subq	$0x64, %rax
               	movslq	%eax, %rax
               	retq
