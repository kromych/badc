
inline_asm_x64_cdqe.x64:	file format elf64-x86-64

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
               	movq	$-0x5, %rax
               	cltq
               	movq	%rax, %rcx
               	movl	$0x2f, %eax
               	cltq
               	cmpq	$-0x5, %rcx
               	jne	<addr>
               	cmpq	$0x2f, %rax
               	jne	<addr>
               	movl	$0x2a, %eax
               	retq
               	movl	$0x1, %eax
               	retq
