
layout_goto_block_addr.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x18, %rsp
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, (%rsp)
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, 0x8(%rsp)
               	movq	%rax, %rcx
               	cmpl	%edi, %eax
               	jge	<addr>
               	movq	%rax, %rsi
               	andq	$0x1, %rsi
               	movq	(%rsp,%rsi,8), %rsi
               	jmpq	*%rsi
               	addq	$0x2, %rcx
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	%edi, %eax
               	jl	<addr>
               	jmp	<addr>
               	incq	%rcx
               	incq	%rax
               	cmpl	%edi, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq

<main>:
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
               	popq	%rbx
               	retq
