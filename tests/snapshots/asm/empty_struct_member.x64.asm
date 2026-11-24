
empty_struct_member.x64:	file format elf64-x86-64

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
               	subq	$0x38, %rsp
               	movq	$0x1111, 0x8(%rsp)      # imm = 0x1111
               	movq	$0x2222, 0x10(%rsp)     # imm = 0x2222
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq
