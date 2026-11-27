
volatile_unused_read.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x18, %rsp
               	movl	<rip>, %eax # <addr>
               	movl	$0x7, 0x8(%rsp)
               	movl	0x8(%rsp), %eax
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movl	0x8(%rsp), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
