
layout_goto_block_addr.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<dispatch>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	%edi, 0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	xorq	%rcx, %rcx
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, 0x8(%rax)
               	movl	%ecx, -0x18(%rbp)
               	movl	%ecx, -0x20(%rbp)
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	addq	$0x2, %rax
               	movl	%eax, -0x18(%rbp)
               	movslq	-0x20(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x20(%rbp)
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x18(%rbp)
               	movslq	-0x20(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x20(%rbp)
               	movslq	-0x20(%rbp), %rax
               	movslq	0x10(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jl	<addr>
               	movslq	-0x18(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	leaq	-0x10(%rbp), %rax
               	movslq	-0x20(%rbp), %rcx
               	andq	$0x1, %rcx
               	movq	(%rax,%rcx,8), %rax
               	jmpq	*%rax

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rbx, %rbx
               	movq	%rbx, %r12
               	jmp	<addr>
               	movslq	%ebx, %rdi
               	callq	<addr>
               	addq	%rax, %r12
               	incq	%rbx
               	movslq	%ebx, %rax
               	cmpq	$0x5, %rax
               	jl	<addr>
               	movslq	%r12d, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
