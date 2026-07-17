
inline_const_array_field_nonnull.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sum_named>:
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rcx
               	addq	$0x0, %rcx
               	movslq	0x28(%rax), %rdx
               	addq	%rdx, %rcx
               	leaq	0x3(%rcx), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
