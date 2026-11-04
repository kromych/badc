
inline_asm_a64_call.x64:	file format elf64-x86-64

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

<bump>:
               	movl	$0x2a, <rip> # <addr>
               	retq

<main>:
               	movl	$0x2a, <rip> # <addr>
               	movl	$0x2a, %eax
               	retq
