
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
               	movslq	%eax, %rax
               	retq

<k>:
               	movl	$0x5, %eax
               	retq

<main>:
               	movl	$0x2, %eax
               	movl	$0x1, %ecx
               	movl	$0x7, %edx
               	movslq	%edx, %rdx
               	cmpq	$0x7, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x5, %edx
               	cmpq	$0x5, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpq	$0x64, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	addq	%rax, %rcx
               	addq	%rcx, %rax
               	subq	$0x5, %rax
               	movslq	%eax, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
