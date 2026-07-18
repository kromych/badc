
inline_asm_x64_movnti.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<store_nt>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	pushq	%rax
               	pushq	%rbx
               	movq	%rax, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	0x8(%rsp), %rax
               	movq	(%rsp), %rbx
               	movntil	%ebx, (%rax)
               	sfence
               	addq	$0x10, %rsp
               	popq	%rbx
               	popq	%rax
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x2a, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
