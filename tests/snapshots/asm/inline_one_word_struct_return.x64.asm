
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
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	leaq	0x1(%rax), %rdx
               	movslq	%edx, %rdx
               	imulq	$0xa, %rdx, %rdx
               	addq	%rdx, %rcx
               	movslq	%eax, %rax
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	cmpq	$0x96, %rcx
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
