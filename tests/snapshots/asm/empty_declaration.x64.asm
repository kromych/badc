
empty_declaration.x64:	file format elf64-x86-64

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
               	movl	$0xb, %eax
               	movl	%eax, <rip> # <addr>
               	movl	$0xc, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	addq	$0xc, %rcx
               	cmpl	$0x17, %ecx
               	je	<addr>
               	retq
               	xorl	%eax, %eax
               	retq
