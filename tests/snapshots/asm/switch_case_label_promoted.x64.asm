
switch_case_label_promoted.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movl	$0x1, %eax
               	movl	$0x3, %eax
               	movl	$0x5, %eax
               	xorq	%rax, %rax
               	retq
               	addb	%al, 0x41(%rdx)
