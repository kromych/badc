
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
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	movq	%rdi, %rcx
               	shlq	$0x1, %rcx
               	leaq	-0x8(%rbp), %rdx
               	movslq	(%rdx), %rax
               	addq	%rcx, %rax
               	movl	%eax, (%rdx)
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	movl	%eax, (%rdx)
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	movl	%eax, (%rdx)
               	movslq	-0x8(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x7, %edi
               	popq	%rbp
               	jmp	<addr>
