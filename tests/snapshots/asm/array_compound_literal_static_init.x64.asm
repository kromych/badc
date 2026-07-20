
array_compound_literal_static_init.x64:	file format elf64-x86-64

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
               	movslq	0x8(%rcx), %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	(%rax), %rcx
               	movq	(%rcx), %rcx
               	movsbq	(%rcx), %rcx
               	cmpq	$0x61, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	0x8(%rax), %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpq	$0x2aa, %rcx            # imm = 0x2AA
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	0x8(%rax), %rcx
               	movq	(%rcx), %rcx
               	movsbq	(%rcx), %rcx
               	cmpq	$0x69, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	movq	(%rcx), %rcx
               	movsbq	0x1(%rcx), %rcx
               	cmpq	$0x66, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	0x8(%rax), %rcx
               	movslq	0x18(%rcx), %rcx
               	cmpq	$0x28b, %rcx            # imm = 0x28B
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	0x8(%rax), %rcx
               	movq	0x10(%rcx), %rcx
               	movsbq	0x1(%rcx), %rcx
               	cmpq	$0x6e, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movq	0x8(%rax), %rcx
               	movslq	0x28(%rcx), %rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movq	0x8(%rax), %rcx
               	movq	0x20(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movq	0x10(%rax), %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpq	$0x7, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	movq	0x10(%rax), %rcx
               	movslq	0x18(%rcx), %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	movq	0x10(%rcx), %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	movq	0x10(%rax), %rax
               	movslq	0x28(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
