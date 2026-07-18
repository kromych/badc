
inline_asm_x64_clflush.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movl	$0x2a, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	pushq	%rax
               	movq	%rax, %r10
               	pushq	%r10
               	movq	(%rsp), %rax
               	prefetcht0	(%rax)
               	clflush	(%rax)
               	addq	$0x8, %rsp
               	popq	%rax
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
