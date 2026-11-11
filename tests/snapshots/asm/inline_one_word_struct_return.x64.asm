
inline_one_word_struct_return.x64:	file format elf64-x86-64

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

<main>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	incq	%rax
               	imulq	$0xa, %rax, %rdx
               	addq	%rdx, %rcx
               	cmpl	$0x5, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movl	$0x1, %edx
               	cmpq	$0x96, %rcx
               	cmovneq	%rdx, %rax
               	retq
