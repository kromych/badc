
self_referential_macro.x64:	file format elf64-x86-64

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

<unwrap>:
               	movslq	(%rdi), %rax
               	retq

<twice>:
               	movslq	(%rdi), %rax
               	shlq	%rax
               	movslq	%eax, %rax
               	retq

<main>:
               	xorq	%rax, %rax
               	retq
