
large_stack_frame.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<big>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x12d0, %rsp           # imm = 0x12D0
               	movq	%r13, (%rsp)
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	incq	%rax
               	incq	%rax
               	movslq	%eax, %rax
               	movq	(%rsp), %r13
               	addq	$0x12d0, %rsp           # imm = 0x12D0
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	movl	$0x28, %eax
               	incq	%rax
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %r13
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
