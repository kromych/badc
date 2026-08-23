
kr_old_style_def.x64:	file format elf64-x86-64

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

<mix>:
               	movsbq	%sil, %rsi
               	movq	%rdi, %rax
               	subq	%rdx, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	retq

<first>:
               	movsbq	(%rdi), %rax
               	retq

<main>:
               	xorq	%rax, %rax
               	retq
