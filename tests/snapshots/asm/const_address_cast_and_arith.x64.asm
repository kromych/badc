
const_address_cast_and_arith.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	0x8(%rax), %rcx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	0x10(%rax), %rcx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	0x18(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0xc8, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	0x20(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0xc8, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	0x28(%rax), %rcx
               	movq	%rdx, %rsi
               	addq	$0x4, %rsi
               	cmpq	%rsi, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movq	0x30(%rax), %rax
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
