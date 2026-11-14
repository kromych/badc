
hex_case_range.x64:	file format elf64-x86-64

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

<classify>:
               	cmpl	$0x10, %edi
               	jge	<addr>
               	cmpl	$0x30, %edi
               	jge	<addr>
               	xorl	%eax, %eax
               	retq
               	cmpl	$0x40, %edi
               	jg	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpl	$0x20, %edi
               	jg	<addr>
               	movl	$0x1, %eax
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
