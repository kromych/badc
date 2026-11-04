
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
               	movl	<rip>, %eax # <addr>
               	imulq	$0xa, %rax, %rax
               	movl	<rip>, %ecx # <addr>
               	addq	%rax, %rcx
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %edx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movq	<rip>, %rax # <addr>
               	movl	0x4(%rax), %edx
               	addq	$0xa, %rdx
               	movl	%edx, 0x4(%rax)
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	addq	%rax, %rcx
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %edx
               	addq	%rdx, %rcx
               	movl	0x4(%rax), %eax
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	movl	(%rcx), %ecx
               	addq	%rcx, %rax
               	subq	$0x64, %rax
               	retq
