
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
               	movq	%rax, %rdx
               	cmpl	$0x5, %eax
               	jge	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rsi
               	imulq	$0xa, %rsi, %rsi
               	addq	%rsi, %rdx
               	movq	%rcx, %rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	cmpq	$0x96, %rdx
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
