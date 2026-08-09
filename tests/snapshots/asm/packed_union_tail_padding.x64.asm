
packed_union_tail_padding.x64:	file format elf64-x86-64

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
               	subq	$0xe0, %rsp
               	leaq	-0x20(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	-0x20(%rbp), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	addq	$0x3c, %rax
               	leaq	-0x98(%rbp), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xd8(%rbp), %rax
               	movl	$0x7, %ecx
               	movb	%cl, 0x3b(%rax)
               	leaq	-0xd8(%rbp), %rax
               	movzbq	0x3b(%rax), %rax
               	xorq	$0x7, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
