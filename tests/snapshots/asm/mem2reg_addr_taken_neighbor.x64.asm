
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
               	shlq	%rdi
               	movl	%edi, -0x8(%rbp)
               	movq	%rdi, %rax
               	addq	%rdi, %rax
               	movl	%eax, -0x8(%rbp)
               	addq	%rdi, %rax
               	movl	%eax, -0x8(%rbp)
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x0, -0x8(%rbp)
               	movl	$0xe, -0x8(%rbp)
               	movl	$0x1c, -0x8(%rbp)
               	movl	$0x2a, %eax
               	movl	%eax, -0x8(%rbp)
               	leave
               	retq
