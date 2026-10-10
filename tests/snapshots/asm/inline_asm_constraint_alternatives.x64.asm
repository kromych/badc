
inline_asm_constraint_alternatives.x64:	file format elf64-x86-64

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
               	movl	$0x5, %ecx
               	addq	%rcx, %rax
               	cmpq	$0x19, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x3, %eax
               	movl	$0x4, %ecx
               	addq	%rcx, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x1, %eax
               	addq	$0x7, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0xa, %eax
               	movl	$0x20, %r10d
               	addq	%r10, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	$0x2a, %eax
               	retq
