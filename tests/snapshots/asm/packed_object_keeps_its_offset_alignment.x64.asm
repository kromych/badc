
packed_object_keeps_its_offset_alignment.x64:	file format elf64-x86-64

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

<read_member>:
               	movq	<rip>, %rax # <addr>
               	movl	%eax, <rip> # <addr>
               	retq

<main>:
               	xorl	%eax, %eax
               	movl	$0x1, %ecx
               	movq	<rip>, %rdx # <addr>
               	cmpq	$0x9, %rdx
               	cmovneq	%rcx, %rax
               	retq
