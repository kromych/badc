
array_compound_literal_address_const.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	0x8(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x2, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	0x10(%rax), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	retq
