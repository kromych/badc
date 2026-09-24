
inline_asm_x64_cmov.x64:	file format elf64-x86-64

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
               	movl	$0x14, %eax
               	movl	$0x2a, %ebx
               	cmpq	%rbx, %rax
               	cmovlq	%rbx, %rax
               	movq	%rax, %rcx
               	movl	$0x2a, %eax
               	movl	$0xa, %ebx
               	cmpq	%rbx, %rax
               	cmovlq	%rbx, %rax
               	movq	%rax, %rdx
               	movl	$0x64, %eax
               	movl	$0x2a, %ebx
               	cmpq	%rbx, %rax
               	cmovgq	%rbx, %rax
               	movq	%rax, %rsi
               	movl	$0x2a, %eax
               	movl	$0x63, %ebx
               	cmpq	%rbx, %rax
               	cmovgq	%rbx, %rax
               	cmpq	$0x2a, %rcx
               	jne	<addr>
               	cmpq	$0x2a, %rdx
               	jne	<addr>
               	cmpq	$0x2a, %rsi
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
