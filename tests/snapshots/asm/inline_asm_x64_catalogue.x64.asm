
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
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movq	$-0x14, %rax
               	negq	%rax
               	movq	%rax, %rcx
               	movq	$-0x8, %rax
               	notq	%rax
               	movq	%rax, %rdx
               	movl	$0x64, %eax
               	movq	$0xf, -0x8(%rbp)
               	movq	-0x8(%rbp), %rbx
               	xchgq	%rbx, %rax
               	movq	%rbx, -0x8(%rbp)
               	movq	%rax, %rsi
               	movl	$0x5, %eax
               	rolq	%rax
               	movq	%rax, %rdi
               	movl	$0x14, %eax
               	movl	$0x16, %ebx
               	addq	$0x0, %rax
               	adcq	%rbx, %rax
               	cmpq	$0x14, %rcx
               	jne	<addr>
               	cmpq	$0x7, %rdx
               	jne	<addr>
               	cmpq	$0xf, %rsi
               	jne	<addr>
               	movq	-0x8(%rbp), %rcx
               	cmpq	$0x64, %rcx
               	jne	<addr>
               	cmpq	$0xa, %rdi
               	jne	<addr>
               	cmpq	$0x2a, %rax
               	jne	<addr>
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
