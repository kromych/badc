
extended_identifiers.x64:	file format elf64-x86-64

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

<mañana>:
               	leaq	0x1(%rdi), %rax
               	retq

<main>:
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpl	$0x3, %eax
               	jne	<addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	xorl	%eax, %eax
               	retq
