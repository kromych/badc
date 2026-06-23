
mem2reg_addr_taken_neighbor.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<g>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%r13, (%rsp)
               	movslq	%edi, %rdi
               	xorq	%rsi, %rsi
               	movl	%esi, -0x8(%rbp)
               	movq	%rdi, %rax
               	shlq	$0x1, %rax
               	movslq	%eax, %rax
               	leaq	-0x8(%rbp), %rcx
               	movslq	%esi, %rdx
               	cmpq	$0x3, %rdx
               	jge	<addr>
               	movslq	(%rcx), %rdx
               	addq	%rax, %rdx
               	movl	%edx, (%rcx)
               	movslq	%esi, %rdx
               	incq	%rdx
               	movslq	%edx, %rsi
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	movq	(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	movl	$0x7, %edi
               	movq	(%rsp), %r13
               	addq	$0x10, %rsp
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
