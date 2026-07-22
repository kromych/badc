
attribute_alias_target_later.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<probe_generic>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	addq	%rdi, %rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	retq

<after_alias>:
               	movl	$0x5, %eax
               	retq

<main>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movslq	(%rax), %rcx
               	addq	$0x2, %rcx
               	movl	%ecx, (%rax)
               	movslq	%ecx, %rcx
               	cmpq	$0x3, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movslq	(%rax), %rcx
               	addq	$0x4, %rcx
               	movl	%ecx, (%rax)
               	movslq	%ecx, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x29, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorq	%rax, %rax
               	retq
