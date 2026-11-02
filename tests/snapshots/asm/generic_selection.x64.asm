
generic_selection.x64:	file format elf64-x86-64

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

<touched>:
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movq	$-0x1, %rax
               	retq

<chosen>:
               	movl	$0x7, %eax
               	retq

<main>:
               	xorl	%eax, %eax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x64, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0xc8, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0xa, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x14, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	retq
