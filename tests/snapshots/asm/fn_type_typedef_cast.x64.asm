
fn_type_typedef_cast.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<use>:
               	xorq	%rax, %rax
               	retq

<caller>:
               	xorq	%rax, %rax
               	retq

<next_fn>:
               	movq	%rdi, %rax
               	cmpq	$0x64, %rsi
               	jbe	<addr>
               	xorq	%rax, %rax
               	retq
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	callq	<addr>
               	movl	$0x5, %esi
               	movl	%esi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x8(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
