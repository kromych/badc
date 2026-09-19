
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
               	movq	%rax, %rdx
               	cmpl	$0x5, %eax
               	jge	<addr>
               	leaq	0x1(%rax), %rcx
               	imulq	$0xa, %rcx, %rsi
               	addq	%rsi, %rdx
               	movq	%rcx, %rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	cmpq	$0x96, %rdx
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
