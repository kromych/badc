
merged_chain_empty_edge_block.x64:	file format elf64-x86-64

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

<steps>:
               	xorl	%eax, %eax
               	leaq	-<rip>, %rcx # <addr>
               	movl	$0x9, %edx
               	testq	%rcx, %rcx
               	cmovneq	%rdx, %rax
               	retq

<main>:
               	leaq	-<rip>, %rax # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	testq	%rax, %rax
               	movq	%rdx, %rax
               	cmovneq	%rcx, %rax
               	retq
