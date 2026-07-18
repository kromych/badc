
inline_multi_block_result_forward.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<test>:
               	movslq	%edi, %rdi
               	movslq	%edi, %rax
               	shlq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rcx
               	leaq	(%rdi,%rdi), %rax
               	cmpq	$0x3, %rdi
               	jle	<addr>
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
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
