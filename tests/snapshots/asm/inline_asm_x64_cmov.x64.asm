
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
               	movl	$0x14, %eax
               	movl	$0x2a, %r10d
               	cmpq	%r10, %rax
               	cmovlq	%r10, %rax
               	movl	$0x2a, %ecx
               	movl	$0xa, %r10d
               	cmpq	%r10, %rcx
               	cmovlq	%r10, %rcx
               	movl	$0x64, %edx
               	movl	$0x2a, %r10d
               	cmpq	%r10, %rdx
               	cmovgq	%r10, %rdx
               	movl	$0x2a, %esi
               	movl	$0x63, %r10d
               	cmpq	%r10, %rsi
               	cmovgq	%r10, %rsi
               	cmpq	$0x2a, %rax
               	jne	<addr>
               	cmpq	$0x2a, %rcx
               	jne	<addr>
               	cmpq	$0x2a, %rdx
               	jne	<addr>
               	cmpq	$0x2a, %rsi
               	jne	<addr>
               	movl	$0x2a, %eax
               	retq
               	movl	$0x1, %eax
               	retq
