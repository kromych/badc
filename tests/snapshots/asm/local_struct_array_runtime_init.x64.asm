
local_struct_array_runtime_init.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	movl	$0x7, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	$0x9, %eax
               	movl	%eax, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movslq	(%rcx), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rdx), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0xb, %eax
               	movl	%eax, (%rcx)
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
