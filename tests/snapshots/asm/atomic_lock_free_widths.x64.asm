
atomic_lock_free_widths.x64:	file format elf64-x86-64

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
               	andq	$-0x10, %rsp
               	xorq	%rax, %rax
               	leaq	(%rbp), %rsp
               	popq	%rbp
               	retq
