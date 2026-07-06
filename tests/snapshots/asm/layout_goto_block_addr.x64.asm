
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
               	xorq	%rdi, %rdi
               	callq	<addr>
               	leaq	(%rax), %rbx
               	movl	$0x1, %edi
               	callq	<addr>
               	addq	%rax, %rbx
               	movl	$0x2, %edi
               	callq	<addr>
               	addq	%rax, %rbx
               	movl	$0x3, %edi
               	callq	<addr>
               	addq	%rax, %rbx
               	movl	$0x4, %edi
               	callq	<addr>
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
