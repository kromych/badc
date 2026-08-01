
minmax_signedness_chain.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	popq	%rdx
               	movl	$0x18, %eax
               	movl	$0xa, %ecx
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	shlq	$0x3, %rax
               	cmpq	$0xa, %rax
               	jbe	<addr>
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
