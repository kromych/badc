
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
               	movslq	%eax, %rax
               	retq

<two>:
               	leaq	<rip>, %rcx
               	movq	%rdi, %rax
               	shlq	$0x1, %rax
               	movl	%eax, (%rcx)
               	movq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, %rcx
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
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
