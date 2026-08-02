
mem2reg_value_across_call.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<cb>:
               	leaq	0x7(%rdi), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	-<rip>, %r12       # <addr>
               	xorq	%rbx, %rbx
               	movq	%rbx, %rax
               	jmp	<addr>
               	movq	%rbx, %rcx
               	shlq	%rcx
               	incq	%rcx
               	leaq	(%rax,%rcx), %r13
               	movq	%r12, %rax
               	movq	%rbx, %rdi
               	callq	*%rax
               	addq	%r13, %rax
               	incq	%rbx
               	cmpq	$0x3, %rbx
               	jl	<addr>
               	andq	$0x7f, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
