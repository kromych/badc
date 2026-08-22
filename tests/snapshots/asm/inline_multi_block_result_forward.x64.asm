
inline_multi_block_result_forward.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<test>:
               	movslq	%edi, %rax
               	shlq	%rax
               	movslq	%eax, %rax
               	leaq	(%rdi,%rdi), %rcx
               	cmpl	$0x3, %edi
               	jle	<addr>
               	retq
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	movl	$0xa, %eax
               	movl	$0xa, %eax
               	retq
