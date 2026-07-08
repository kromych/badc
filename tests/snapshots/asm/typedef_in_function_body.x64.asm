
typedef_in_function_body.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<g>:
               	movl	$0x7, %eax
               	retq

<k>:
               	movl	$0x5, %eax
               	retq

<main>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
