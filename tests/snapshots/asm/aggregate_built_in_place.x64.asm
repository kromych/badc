
aggregate_built_in_place.x64:	file format elf64-x86-64

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
               	leaq	(%rsp), %rax
               	movq	$0x7, (%rsp)
               	movq	$0x8, 0x8(%rsp)
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	(%rax), %rax
               	movq	(%rsp), %rcx
               	addq	%rcx, %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
