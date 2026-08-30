
switch_jump_table_sparse_kept.x64:	file format elf64-x86-64

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
               	movl	$0x1, %eax
               	movl	$0x2, %eax
               	movl	$0x3, %eax
               	movl	$0x4, %eax
               	movl	$0x5, %eax
               	movl	$0x6, %eax
               	movl	$0x7, %eax
               	movl	$0x8, %eax
               	movl	$0x9, %eax
               	movl	$0xa, %eax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	xorq	%rax, %rax
               	retq
