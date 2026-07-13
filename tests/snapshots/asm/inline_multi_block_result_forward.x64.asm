
inline_multi_block_result_forward.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<helper_one>:
               	leaq	(%rdi,%rdi), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<helper_two>:
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	shlq	$0x1, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<test>:
               	movslq	%edi, %rdi
               	movslq	%edi, %rax
               	shlq	$0x1, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	(%rdi,%rdi), %rcx
               	cmpq	$0x3, %rdi
               	jle	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
