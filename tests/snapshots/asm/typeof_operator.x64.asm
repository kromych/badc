
typeof_operator.x64:	file format elf64-x86-64

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

<with_side_effect>:
               	movl	$0x1, <rip> # <addr>
               	movl	$0x7, %eax
               	retq

<main>:
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	xorl	%eax, %eax
               	retq
