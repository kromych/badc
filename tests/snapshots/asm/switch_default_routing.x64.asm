
switch_default_routing.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movl	$0x64, %eax
               	movl	$0x64, %eax
               	retq
               	addb	%al, 0x41(%rdx)
