
const_expr_conditional.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movl	$0x5, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x7, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0xe, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x1, %ecx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	-0x10(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	addq	%rcx, %rax
               	leaq	-0x10(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x10(%rbp), %rcx
               	movslq	0xc(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
