
inline_asm_x64_catalogue.x64:	file format elf64-x86-64

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
               	movq	$-0x14, %rax
               	movq	%rax, %rdx
               	negq	%rdx
               	movq	$-0x8, %rax
               	movq	%rax, %rsi
               	notq	%rsi
               	movl	$0x64, %eax
               	movl	$0xf, %ecx
               	xchgq	%rcx, %rax
               	movl	$0x5, %edi
               	rolq	%rdi
               	movl	$0x14, %r8d
               	movl	$0x16, %r10d
               	addq	$0x0, %r8
               	adcq	%r10, %r8
               	cmpq	$0x14, %rdx
               	jne	<addr>
               	cmpq	$0x7, %rsi
               	jne	<addr>
               	cmpq	$0xf, %rax
               	jne	<addr>
               	cmpq	$0x64, %rcx
               	jne	<addr>
               	cmpq	$0xa, %rdi
               	jne	<addr>
               	cmpq	$0x2a, %r8
               	jne	<addr>
               	movl	$0x2a, %eax
               	retq
               	movl	$0x1, %eax
               	retq
