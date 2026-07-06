
large_stack_frame.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<big>:
               	leaq	0x1(%rdi), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	retq

<main>:
               	movl	$0x28, %eax
               	incq	%rax
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
