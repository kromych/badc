
generic_selection.x64:	file format elf64-x86-64

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

<touched>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	$-0x1, %rax
               	retq

<chosen>:
               	movl	$0x7, %eax
               	retq

<main>:
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	movl	%eax, (%rcx)
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	cmpl	$0x64, %edx
               	jne	<addr>
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0xc8, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0xa, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x14, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	retq
