
zero_length_local_array.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<in_stmt_expr>:
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rdx
               	leaq	-0x18(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	addq	%rdx, %rax
               	subq	$0x3, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
