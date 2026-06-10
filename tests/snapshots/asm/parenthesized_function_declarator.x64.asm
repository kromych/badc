
parenthesized_function_declarator.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<one>:
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	retq

<two>:
               	movslq	%edi, %rdi
               	leaq	<rip>, %rax
               	movq	%rdi, %rcx
               	shlq	$0x1, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, (%rax)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xa, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x5, %edi
               	callq	<addr>
               	movslq	%ebx, %rcx
               	cmpq	$0xb, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x0, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movslq	(%rax), %rax
               	cmpq	$0xa, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
