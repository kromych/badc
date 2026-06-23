
typedef_in_function_body.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<g>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%r13, (%rsp)
               	movl	$0x7, %eax
               	movq	(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<k>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%r13, (%rsp)
               	movl	$0x5, %eax
               	movq	(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%r13, (%rsp)
               	movl	$0x2, %eax
               	movl	$0x1, %ecx
               	movl	$0x7, %edx
               	cmpq	$0x7, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %edx
               	cmpq	$0x5, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpq	$0x64, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addq	%rax, %rcx
               	addq	%rcx, %rax
               	subq	$0x5, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
