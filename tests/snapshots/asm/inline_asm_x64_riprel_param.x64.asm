
inline_asm_x64_riprel_param.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	<rip>, %rax
               	movq	%rax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rax, -0x30(%rbp)
               	leaq	<rip>, %rax
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x18(%rbp), %rax
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdx
               	movq	%rax, -0x40(%rbp)
               	movq	%rdx, -0x38(%rbp)
               	movq	%rax, -0x30(%rbp)
               	leaq	<rip>, %rax
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x20(%rbp), %rax
               	movq	(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
