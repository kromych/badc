
comma_operator_in_loops.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<bump>:
               	movq	%rdi, %rcx
               	movslq	%ecx, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rbx, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorq	%rdi, %rdi
               	callq	<addr>
               	movl	$0x7, %edi
               	callq	<addr>
               	xorq	%rdi, %rdi
               	callq	<addr>
               	xorq	%rdi, %rdi
               	callq	<addr>
               	xorq	%rdi, %rdi
               	callq	<addr>
               	xorq	%rdi, %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
