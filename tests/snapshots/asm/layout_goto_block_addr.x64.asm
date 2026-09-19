
layout_goto_block_addr.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<dispatch>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	%edi, -0x30(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, (%rax)
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, 0x8(%rax)
               	movl	$0x0, -0x18(%rbp)
               	movl	$0x0, -0x20(%rbp)
               	movslq	-0x20(%rbp), %rcx
               	movslq	-0x30(%rbp), %rdx
               	cmpl	%edx, %ecx
               	jge	<addr>
               	movslq	-0x20(%rbp), %rcx
               	andq	$0x1, %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x18(%rbp), %rcx
               	addq	$0x2, %rcx
               	movl	%ecx, -0x18(%rbp)
               	movslq	-0x20(%rbp), %rcx
               	incq	%rcx
               	movl	%ecx, -0x20(%rbp)
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rcx
               	incq	%rcx
               	movl	%ecx, -0x18(%rbp)
               	movslq	-0x20(%rbp), %rcx
               	incq	%rcx
               	movl	%ecx, -0x20(%rbp)
               	movslq	-0x20(%rbp), %rcx
               	movslq	-0x30(%rbp), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	movslq	-0x18(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %rbx
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
               	popq	%rbx
               	leave
               	retq
