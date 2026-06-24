
inline_keyword_uncaps.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<widen>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rdi, %rax
               	incq	%rax
               	addq	$0x2, %rax
               	addq	$0x3, %rax
               	addq	$0x4, %rax
               	addq	$0x5, %rax
               	addq	$0x6, %rax
               	addq	$0x7, %rax
               	addq	$0x8, %rax
               	addq	$0x9, %rax
               	addq	$0xa, %rax
               	addq	$0xb, %rax
               	addq	$0xc, %rax
               	addq	$0xd, %rax
               	addq	$0xe, %rax
               	addq	$0xf, %rax
               	addq	$0x10, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorq	%rax, %rax
               	incq	%rax
               	addq	$0x2, %rax
               	addq	$0x3, %rax
               	addq	$0x4, %rax
               	addq	$0x5, %rax
               	addq	$0x6, %rax
               	addq	$0x7, %rax
               	addq	$0x8, %rax
               	addq	$0x9, %rax
               	addq	$0xa, %rax
               	addq	$0xb, %rax
               	addq	$0xc, %rax
               	addq	$0xd, %rax
               	addq	$0xe, %rax
               	addq	$0xf, %rax
               	addq	$0x10, %rax
               	movl	$0x64, %ecx
               	incq	%rcx
               	addq	$0x2, %rcx
               	addq	$0x3, %rcx
               	addq	$0x4, %rcx
               	addq	$0x5, %rcx
               	addq	$0x6, %rcx
               	addq	$0x7, %rcx
               	addq	$0x8, %rcx
               	addq	$0x9, %rcx
               	addq	$0xa, %rcx
               	addq	$0xb, %rcx
               	addq	$0xc, %rcx
               	addq	$0xd, %rcx
               	addq	$0xe, %rcx
               	addq	$0xf, %rcx
               	addq	$0x10, %rcx
               	addq	%rcx, %rax
               	cmpq	$0x174, %rax            # imm = 0x174
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
