
use_after_free.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	pushq	%rbx
               	movl	$0x8, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x2a, (%rbx)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	(%rbx), %eax
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq
