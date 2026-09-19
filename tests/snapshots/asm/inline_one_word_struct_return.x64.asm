
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
               	cmpq	$0x96, %rcx
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
