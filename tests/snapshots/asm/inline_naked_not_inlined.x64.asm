
inline_naked_not_inlined.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<identity_asm>:
               	movq	%rdi, %rax
               	retq

<use_identity>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	incq	%rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x29, %edi
               	callq	<addr>
               	incq	%rax
               	cmpq	$0x2a, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
