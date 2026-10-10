
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
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	imulq	$0xa, %rax, %rax
               	leaq	<rip>, %rcx      # <addr>
               	movl	(%rcx), %ecx
               	leaq	(%rax,%rcx), %rsi
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	movl	(%rcx), %edx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rdx
               	movl	0x4(%rdx), %edi
               	addq	$0xa, %rdi
               	movl	%edi, 0x4(%rdx)
               	movq	(%rax), %rax
               	movl	(%rax), %eax
               	leaq	(%rsi,%rax), %rdx
               	movq	(%rcx), %rax
               	movl	(%rax), %ecx
               	addq	%rdx, %rcx
               	movl	0x4(%rax), %eax
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rcx
               	movl	(%rcx), %ecx
               	addq	%rcx, %rax
               	subq	$0x64, %rax
               	retq
