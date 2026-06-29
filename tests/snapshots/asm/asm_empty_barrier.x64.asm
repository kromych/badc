
asm_empty_barrier.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<barrier_input>:
               	xorq	%rax, %rax
               	retq

<barrier_memory>:
               	xorq	%rax, %rax
               	retq

<barrier_bare>:
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x29, %eax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x8(%rbp)
               	leaq	<rip>, %rax
               	movslq	-0x8(%rbp), %rcx
               	movl	%ecx, (%rax)
               	movslq	%ecx, %rax
               	subq	$0x2a, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
