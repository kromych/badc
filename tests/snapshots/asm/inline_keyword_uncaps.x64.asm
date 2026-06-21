
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
               	subq	$0x90, %rsp
               	movq	%r13, (%rsp)
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
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r13, 0x8(%rsp)
               	xorq	%rdi, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x64, %edi
               	callq	<addr>
               	addq	%rbx, %rax
               	cmpq	$0x174, %rax            # imm = 0x174
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
