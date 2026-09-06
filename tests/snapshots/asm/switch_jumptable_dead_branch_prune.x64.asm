
switch_jumptable_dead_branch_prune.x64:	file format elf64-x86-64

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
               	movl	$0xa, %eax
               	movl	$0x15, %eax
               	movl	$0x20, %eax
               	movl	$0x2b, %eax
               	movl	$0x36, %eax
               	movl	$0x41, %eax
               	movl	$0x4c, %eax
               	movl	$0x57, %eax
               	movl	$0x62, %eax
               	movl	$0x13, %eax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movl	$0xc, %eax
               	retq
