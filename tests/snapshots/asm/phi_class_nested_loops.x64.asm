
phi_class_nested_loops.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<test>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rdi
               	xorq	%r8, %r8
               	movq	%r8, %r9
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	incq	%rax
               	movslq	%eax, %rax
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	addq	%r8, %rax
               	movslq	%eax, %r8
               	leaq	0x1(%rbx), %r9
               	movslq	%r9d, %rbx
               	cmpq	%rdi, %rbx
               	jl	<addr>
               	movslq	%r8d, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x7, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
