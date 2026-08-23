
spill_slot_reuse_disjoint_calls.x64:	file format elf64-x86-64

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
               	movl	$0x110, %eax            # imm = 0x110
               	movl	$0x3, %eax
               	movl	$0x1e, %eax
               	xorq	%rax, %rax
               	retq
