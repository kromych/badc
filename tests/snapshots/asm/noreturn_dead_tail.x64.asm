
noreturn_dead_tail.x64:	file format elf64-x86-64

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
               	movl	$0x5, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%eax, %eax
               	retq
