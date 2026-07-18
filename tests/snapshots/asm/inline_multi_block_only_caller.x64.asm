
inline_multi_block_only_caller.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<run>:
               	imulq	$0x64, %rdi, %rax
               	addq	%rsi, %rax
               	movslq	%edi, %rcx
               	addq	%rcx, %rcx
               	movslq	%ecx, %rdx
               	movslq	%edx, %rcx
               	addq	%rcx, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<main>:
               	movl	$0x2a, %eax
               	retq
