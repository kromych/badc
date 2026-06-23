
switch_statement.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%r13, (%rsp)
               	movl	$0x2, %eax
               	xorq	%rdx, %rdx
               	cmpq	$0x2, %rax
               	jl	<addr>
               	jmp	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	jmp	<addr>
               	movl	$0x14, %edx
               	movq	%rdx, %rax
               	addq	$0x5, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0x64, %eax
               	jmp	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x3, %rax
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
