
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
               	shlq	%rax
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
               	subq	$0x30, %rsp
               	xorq	%rcx, %rcx
               	movl	%ecx, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0xe, %rcx
               	movl	%ecx, (%rax)
               	movslq	%ecx, %rcx
               	addq	$0xe, %rcx
               	movl	%ecx, (%rax)
               	movslq	%ecx, %rcx
               	addq	$0xe, %rcx
               	movl	%ecx, (%rax)
               	movslq	-0x10(%rbp), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
