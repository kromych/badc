
file_scope_asm_local_labels.x64:	file format elf64-x86-64

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
               	xorl	%eax, %eax
               	retq
		...
               	addb	%dh, %dh

<em_div_ex>:
               	divb	%cl
               	retq
               	nop
               	nopw	%cs:(%rax,%rax)

<div_cx>:
               	divw	%cx
               	retq
