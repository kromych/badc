
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
               	leaq	-<rip>, %rcx        # <addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	retq

<main>:
               	leaq	-<rip>, %rax       # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
