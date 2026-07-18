
parenthesized_function_declarator.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<one>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<two>:
               	leaq	<rip>, %rcx
               	movq	%rdi, %rax
               	shlq	%rax
               	movl	%eax, (%rcx)
               	movq	%rcx, %rax
               	retq

<main>:
               	leaq	<rip>, %rcx
               	movl	$0xa, %eax
               	movl	%eax, (%rcx)
               	testq	%rcx, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	(%rcx), %rax
               	cmpq	$0xa, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
