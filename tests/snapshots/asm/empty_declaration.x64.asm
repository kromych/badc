
empty_declaration.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	leaq	<rip>, %rcx
               	movl	$0xb, %edx
               	movl	%edx, (%rcx)
               	leaq	<rip>, %rdi
               	movl	$0xc, %esi
               	movl	%esi, (%rdi)
               	movslq	(%rcx), %rcx
               	movslq	%esi, %rsi
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0x17, %rcx
               	je	<addr>
               	movq	%rdx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
