
paren_comma_side_effect.x64:	file format elf64-x86-64

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
               	movl	$0x0, <rip> # <addr>
               	movl	$0x7, <rip> # <addr>
               	movl	$0x1, <rip> # <addr>
               	movl	$0xb, <rip> # <addr>
               	movl	$0xd, <rip> # <addr>
               	xorl	%eax, %eax
               	retq
