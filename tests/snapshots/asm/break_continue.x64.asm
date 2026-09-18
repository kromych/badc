
break_continue.x64:	file format elf64-x86-64

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
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rdx
               	andq	$0x1, %rdx
               	subq	%rsi, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	jmp	<addr>
               	addq	%rax, %rcx
               	incq	%rax
               	cmpl	$0xa, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	retq
