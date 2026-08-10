
attribute_c23.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<classify>:
               	movslq	%edi, %rdi
               	xorq	%rax, %rax
               	cmpq	$0x2, %rdi
               	jl	<addr>
               	cmpq	$0x2, %rdi
               	je	<addr>
               	movabsq	$-0x1, %rax
               	movslq	%eax, %rax
               	retq
               	incq	%rax
               	jmp	<addr>
               	cmpq	$0x1, %rdi
               	jne	<addr>
               	movl	$0xa, %eax
               	jmp	<addr>

<main>:
               	xorq	%rax, %rax
               	movl	$0xa, %eax
               	movl	$0xb, %eax
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	movabsq	$-0x1, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	retq

<die>:
               	jmp	<addr>
