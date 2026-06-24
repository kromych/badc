
kr_old_style_def.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<mix>:
               	movslq	%edi, %rdi
               	movsbq	%sil, %rsi
               	movq	%rdi, %rax
               	subq	%rdx, %rax
               	addq	%rsi, %rax
               	retq

<first>:
               	movsbq	(%rdi), %rax
               	retq

<main>:
               	movl	$0x1, %eax
               	xorq	%rcx, %rcx
               	movq	%rax, %r10
               	subq	%r10, %rax
               	addq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0xa, %eax
               	movl	$0x5, %ecx
               	movl	$0x3, %edx
               	subq	%rdx, %rax
               	addq	%rcx, %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x5a, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	retq
