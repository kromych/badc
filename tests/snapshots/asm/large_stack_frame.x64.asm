
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
               	subq	$0x12c0, %rsp           # imm = 0x12C0
               	movq	%rdi, %rax
               	incq	%rax
               	incq	%rax
               	movslq	%eax, %rax
               	addq	$0x12c0, %rsp           # imm = 0x12C0
               	popq	%rbp
               	retq

<main>:
               	movl	$0x28, %eax
               	incq	%rax
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	retq
               	addb	%al, (%rax)
