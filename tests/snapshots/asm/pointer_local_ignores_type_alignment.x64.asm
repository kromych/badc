
pointer_local_ignores_type_alignment.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<via_struct_pointer>:
               	movslq	(%rdi), %rax
               	movslq	0x4(%rdi), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<via_scalar_pointer>:
               	movslq	(%rdi), %rax
               	movslq	0xc(%rdi), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
