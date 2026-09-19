
mem2reg_addr_taken_neighbor.x64:	file format elf64-x86-64

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

<g>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x0, -0x8(%rbp)
               	movq	%rdi, %rax
               	shlq	%rax
               	leaq	-0x8(%rbp), %rdx
               	movl	%eax, (%rdx)
               	movq	%rax, %rcx
               	addq	%rax, %rcx
               	movl	%ecx, (%rdx)
               	addq	%rcx, %rax
               	movl	%eax, (%rdx)
               	movslq	-0x8(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x0, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	$0xe, (%rax)
               	movl	$0x1c, (%rax)
               	movl	$0x2a, (%rax)
               	movslq	-0x8(%rbp), %rax
               	leave
               	retq
