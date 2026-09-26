
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	$-0x14, %rax
               	movq	%rax, %rcx
               	negq	%rcx
               	movq	$-0x8, %rax
               	movq	%rax, %rdx
               	notq	%rdx
               	movl	$0x64, %eax
               	movl	$0xf, %esi
               	movq	%rsi, %rbx
               	xchgq	%rbx, %rax
               	movl	$0x5, %esi
               	rolq	%rsi
               	movl	$0x14, %edi
               	movl	$0x16, %r10d
               	addq	$0x0, %rdi
               	adcq	%r10, %rdi
               	cmpq	$0x14, %rcx
               	jne	<addr>
               	cmpq	$0x7, %rdx
               	jne	<addr>
               	cmpq	$0xf, %rax
               	jne	<addr>
               	cmpq	$0x64, %rbx
               	jne	<addr>
               	cmpq	$0xa, %rsi
               	jne	<addr>
               	cmpq	$0x2a, %rdi
               	jne	<addr>
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
