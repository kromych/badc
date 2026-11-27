
inline_volatile_callee.x64:	file format elf64-x86-64

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

<local_pair>:
               	subq	$0x18, %rsp
               	movl	$0x3, 0x8(%rsp)
               	movl	0x8(%rsp), %eax
               	movl	$0x4, %eax
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x18, %rsp
               	movl	<rip>, %eax # <addr>
               	movl	%eax, (%rsp)
               	movl	(%rsp), %eax
               	movl	$0x1, 0x8(%rsp)
               	callq	<addr>
               	addq	$0x3, %rax
               	subq	$0x7, %rax
               	addq	$0x18, %rsp
               	retq
