
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
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	imulq	$0xa, %rax, %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %ecx
               	leaq	(%rax,%rcx), %rsi
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	movslq	0x4(%rdx), %rdi
               	addq	$0xa, %rdi
               	movl	%edi, 0x4(%rdx)
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	leaq	(%rsi,%rax), %rdx
               	movq	(%rcx), %rax
               	movslq	(%rax), %rcx
               	addq	%rdx, %rcx
               	movslq	0x4(%rax), %rax
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	subq	$0x64, %rax
               	retq
