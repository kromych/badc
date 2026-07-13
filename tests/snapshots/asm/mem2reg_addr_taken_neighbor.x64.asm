
mem2reg_addr_taken_neighbor.x64:	file format elf64-x86-64

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
               	xorq	%rdx, %rdx
               	movl	%edx, -0x8(%rbp)
               	movq	%rdi, %rax
               	shlq	$0x1, %rax
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	addq	%rax, %rdx
               	movl	%edx, (%rcx)
               	movslq	%edx, %rdx
               	addq	%rax, %rdx
               	movl	%edx, (%rcx)
               	movslq	%edx, %rdx
               	addq	%rdx, %rax
               	movl	%eax, (%rcx)
               	movslq	-0x8(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x7, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
