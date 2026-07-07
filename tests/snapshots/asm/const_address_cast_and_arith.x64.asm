
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
               	movq	(%rax), %rdx
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	0x8(%rax), %rdx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	0x10(%rax), %rdx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	0x18(%rax), %rdx
               	movslq	(%rdx), %rdx
               	cmpq	$0xc8, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	0x20(%rax), %rdx
               	movslq	(%rdx), %rdx
               	cmpq	$0xc8, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	0x28(%rax), %rdx
               	leaq	0x4(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movq	0x30(%rax), %rax
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	xorq	%rax, %rax
               	retq
