
const_conditional_address_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x1e, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	0x8(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x28, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	0x10(%rax), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
